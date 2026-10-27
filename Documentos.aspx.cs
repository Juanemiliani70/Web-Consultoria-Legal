using System;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace Parcial2_LP3
{
    public partial class Documentos : System.Web.UI.Page
    {
        // Extensiones permitidas (lista blanca) y tamaño máximo: 5 MB
        private static readonly string[] ExtensionesPermitidas =
            { ".pdf", ".doc", ".docx", ".txt", ".jpg", ".jpeg", ".png" };
        private const int TamanoMaximoBytes = 5 * 1024 * 1024;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Si no inició sesión, lo manda al login
            if (Session["autenticado"] == null || Session["usuario"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Saludo personalizado con los datos de la sesión
                lblBienvenida.Text = "Hola, " + Session["nombreCompleto"]
                    + " (usuario: " + Session["usuario"] + ")";
                CargarLista();
            }
        }

        // Devuelve la carpeta personal del usuario dentro de App_Data (no accesible por URL)
        private string CarpetaUsuario()
        {
            // Deja solo letras, números, guion y guion bajo, para evitar rutas peligrosas
            string usuario = Regex.Replace(Session["usuario"].ToString(), "[^a-zA-Z0-9_-]", "_");
            string ruta = Server.MapPath("~/App_Data/Documentos/" + usuario);

            // Si la carpeta no existe, la crea
            Directory.CreateDirectory(ruta);
            return ruta;
        }

        // Muestra el mensaje de resultado en verde (ok) o rojo (error)
        private void Mensaje(string texto, bool exito)
        {
            lblResultado.Text = texto;
            lblResultado.CssClass = exito ? "mensaje-exito" : "resumen-errores";
            lblResultado.Visible = true;
        }

        // Llena la grilla con los archivos de la carpeta del usuario
        private void CargarLista()
        {
            var archivos = new DirectoryInfo(CarpetaUsuario())
                .GetFiles()
                .OrderByDescending(f => f.LastWriteTime)
                .Select(f => new
                {
                    Nombre = f.Name,
                    Tamano = (f.Length / 1024.0).ToString("N1") + " KB",
                    Fecha = f.LastWriteTime.ToString("dd/MM/yyyy HH:mm")
                })
                .ToList();

            gvDocumentos.DataSource = archivos;
            gvDocumentos.DataBind();
        }

        // Click en "Subir documento"
        protected void btnSubir_Click(object sender, EventArgs e)
        {
            // 1) Verifica que haya elegido un archivo
            if (!fuDocumento.HasFile)
            {
                Mensaje("Elegí un archivo antes de subir.", false);
                return;
            }

            // 2) Verifica que no esté vacío ni supere los 5 MB
            int tamano = fuDocumento.PostedFile.ContentLength;
            if (tamano == 0)
            {
                Mensaje("El archivo está vacío.", false);
                return;
            }
            if (tamano > TamanoMaximoBytes)
            {
                Mensaje("El archivo supera el máximo de 5 MB.", false);
                return;
            }

            // 3) Verifica la extensión contra la lista blanca
            string nombreOriginal = Path.GetFileName(fuDocumento.FileName); // quita cualquier ruta
            string extension = Path.GetExtension(nombreOriginal).ToLower();
            if (!ExtensionesPermitidas.Contains(extension))
            {
                Mensaje("Tipo de archivo no permitido. Formatos válidos: "
                    + string.Join(", ", ExtensionesPermitidas), false);
                return;
            }

            // 4) Limpia el nombre: solo letras, números, punto, guion y guion bajo
            string baseNombre = Path.GetFileNameWithoutExtension(nombreOriginal);
            baseNombre = Regex.Replace(baseNombre, @"[^a-zA-Z0-9_\-\. ]", "_");
            string nombreFinal = baseNombre + extension;

            // 5) Si ya existe un archivo con ese nombre, agrega fecha y hora para no pisarlo
            string carpeta = CarpetaUsuario();
            if (File.Exists(Path.Combine(carpeta, nombreFinal)))
            {
                nombreFinal = baseNombre + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + extension;
            }

            // 6) Guarda el archivo en la carpeta personal
            try
            {
                fuDocumento.SaveAs(Path.Combine(carpeta, nombreFinal));
                Mensaje("Documento subido correctamente: " + nombreFinal, true);
                CargarLista();
            }
            catch (Exception)
            {
                Mensaje("No se pudo guardar el archivo. Intentá de nuevo.", false);
            }
        }

        // Click en "Descargar" dentro de la grilla
        protected void gvDocumentos_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Descargar")
            {
                return;
            }

            // Path.GetFileName evita que se pida un archivo fuera de la carpeta del usuario
            string nombre = Path.GetFileName(e.CommandArgument.ToString());
            string ruta = Path.Combine(CarpetaUsuario(), nombre);

            if (!File.Exists(ruta))
            {
                Mensaje("El archivo ya no existe.", false);
                CargarLista();
                return;
            }

            Response.Clear();
            Response.ContentType = "application/octet-stream";
            Response.AddHeader("Content-Disposition",
                "attachment; filename=\"" + HttpUtility.UrlPathEncode(nombre) + "\"");
            Response.TransmitFile(ruta);
            Response.Flush();
            Response.SuppressContent = true;
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }

        // Click en "Cerrar sesión"
        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}