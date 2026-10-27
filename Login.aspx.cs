using System;
using System.Web;

namespace Parcial2_LP3
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Se ejecuta al hacer click en "Ingresar"
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Si falta algún dato, no sigue
            if (!Page.IsValid)
            {
                return;
            }

            // Datos guardados en el registro: usuario en la sesión, contraseña en la cookie
            string usuarioRegistrado = Session["usuario"] as string;
            HttpCookie cookieClave = Request.Cookies["clave"];

            // Si no hay nada guardado, la persona tiene que registrarse primero
            if (usuarioRegistrado == null || cookieClave == null)
            {
                lblError.Text = "No hay ningún usuario registrado. Registrate primero.";
                lblError.Visible = true;
                return;
            }

            // Compara lo escrito con lo guardado
            bool usuarioOk = txtUsuario.Text.Trim() == usuarioRegistrado;
            bool claveOk = txtPassword.Text == cookieClave.Value;

            if (usuarioOk && claveOk)
            {
                // Marca la sesión como iniciada y redirige al espacio personal
                Session["autenticado"] = true;
                Response.Redirect("~/Documentos.aspx");
            }
            else
            {
                lblError.Text = "Usuario o contraseña incorrectos.";
                lblError.Visible = true;
            }
        }
    }
}