using System;
using System.Web;

namespace Parcial2_LP3
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Se ejecuta al hacer click en "Registrar"
        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            // Si algún validador falla, no se guarda nada
            if (!Page.IsValid)
            {
                return;
            }

            // 1) El nombre de usuario se guarda en una SESIÓN (vive en el servidor)
            Session["usuario"] = txtUsuario.Text.Trim();
            Session["nombreCompleto"] = txtNombre.Text.Trim() + " " + txtApellido.Text.Trim();

            // 2) La contraseña se guarda en una COOKIE (vive en el navegador)
            HttpCookie cookieClave = new HttpCookie("clave", txtPassword.Text);
            cookieClave.Expires = DateTime.Now.AddDays(1); // dura 1 día
            cookieClave.HttpOnly = true;                   // el JavaScript de la página no puede leerla
            Response.Cookies.Add(cookieClave);

            // Muestra el mensaje de éxito
            lblMensaje.Text = "¡Registro exitoso! Usuario registrado: " + txtUsuario.Text.Trim();
            pnlExito.Visible = true;
        }
    }
}