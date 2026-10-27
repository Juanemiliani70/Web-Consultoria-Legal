<%@ Page Title="Iniciar sesión" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Parcial2_LP3.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContenido" runat="server">

    <div class="tarjeta formulario">
        <h2>Iniciar sesión</h2>
        <p>Ingresá con el usuario y la contraseña con los que te registraste.</p>

        <%-- Mensaje de error si los datos no coinciden --%>
        <asp:Label ID="lblError" runat="server" CssClass="resumen-errores"
            Visible="false"></asp:Label>

        <%-- Usuario --%>
        <div class="campo">
            <label for="<%= txtUsuario.ClientID %>">Nombre de usuario</label>
            <asp:TextBox ID="txtUsuario" runat="server" MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsuario" runat="server"
                ControlToValidate="txtUsuario" CssClass="error" Display="Dynamic"
                ErrorMessage="Ingresá tu nombre de usuario"></asp:RequiredFieldValidator>
        </div>

        <%-- Contraseña --%>
        <div class="campo">
            <label for="<%= txtPassword.ClientID %>">Contraseña</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                ControlToValidate="txtPassword" CssClass="error" Display="Dynamic"
                ErrorMessage="Ingresá tu contraseña"></asp:RequiredFieldValidator>
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Ingresar"
            CssClass="boton" OnClick="btnLogin_Click" />

        <p style="margin-top: 18px;">
            ¿No tenés cuenta?
            <asp:HyperLink ID="lnkRegistro" runat="server" NavigateUrl="~/Registro.aspx">Registrate acá</asp:HyperLink>
        </p>
    </div>

</asp:Content>