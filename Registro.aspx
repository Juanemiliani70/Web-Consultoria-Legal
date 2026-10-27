<%@ Page Title="Registro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="Parcial2_LP3.Registro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContenido" runat="server">

    <div class="tarjeta formulario">
        <h2>Registro de clientes</h2>
        <p>Completá todos los campos para crear tu cuenta.</p>

        <%-- Resumen de errores: junta los mensajes de todos los validadores --%>
        <asp:ValidationSummary ID="vsResumen" runat="server"
            CssClass="resumen-errores"
            HeaderText="Revisá los siguientes datos:" />

        <%-- Nombre --%>
        <div class="campo">
            <label for="<%= txtNombre.ClientID %>">Nombre</label>
            <asp:TextBox ID="txtNombre" runat="server" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                ControlToValidate="txtNombre" CssClass="error" Display="Dynamic"
                ErrorMessage="El nombre es obligatorio" Text="*"></asp:RequiredFieldValidator>
        </div>

        <%-- Apellido --%>
        <div class="campo">
            <label for="<%= txtApellido.ClientID %>">Apellido</label>
            <asp:TextBox ID="txtApellido" runat="server" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvApellido" runat="server"
                ControlToValidate="txtApellido" CssClass="error" Display="Dynamic"
                ErrorMessage="El apellido es obligatorio" Text="*"></asp:RequiredFieldValidator>
        </div>

        <%-- Correo electrónico: obligatorio y con formato válido --%>
        <div class="campo">
            <label for="<%= txtEmail.ClientID %>">Correo electrónico</label>
            <asp:TextBox ID="txtEmail" runat="server" MaxLength="100"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                ControlToValidate="txtEmail" CssClass="error" Display="Dynamic"
                ErrorMessage="El correo electrónico es obligatorio" Text="*"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server"
                ControlToValidate="txtEmail" CssClass="error" Display="Dynamic"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                ErrorMessage="El formato del correo no es válido (ejemplo: nombre@dominio.com)"
                Text="*"></asp:RegularExpressionValidator>
        </div>

        <%-- Nombre de usuario --%>
        <div class="campo">
            <label for="<%= txtUsuario.ClientID %>">Nombre de usuario</label>
            <asp:TextBox ID="txtUsuario" runat="server" MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsuario" runat="server"
                ControlToValidate="txtUsuario" CssClass="error" Display="Dynamic"
                ErrorMessage="El nombre de usuario es obligatorio" Text="*"></asp:RequiredFieldValidator>
        </div>

        <%-- Edad: solo números enteros y mayor de 15 --%>
        <div class="campo">
            <label for="<%= txtEdad.ClientID %>">Edad</label>
            <asp:TextBox ID="txtEdad" runat="server" MaxLength="3"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEdad" runat="server"
                ControlToValidate="txtEdad" CssClass="error" Display="Dynamic"
                ErrorMessage="La edad es obligatoria" Text="*"></asp:RequiredFieldValidator>
            <%-- Type="Integer" rechaza letras y decimales; el mínimo 16 deja afuera a los de 15 o menos --%>
            <asp:RangeValidator ID="rvEdad" runat="server"
                ControlToValidate="txtEdad" Type="Integer"
                MinimumValue="16" MaximumValue="120"
                CssClass="error" Display="Dynamic"
                ErrorMessage="La edad debe ser un número y tenés que ser mayor de 15 años"
                Text="*"></asp:RangeValidator>
        </div>

        <%-- Contraseña --%>
        <div class="campo">
            <label for="<%= txtPassword.ClientID %>">Contraseña</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                ControlToValidate="txtPassword" CssClass="error" Display="Dynamic"
                ErrorMessage="La contraseña es obligatoria" Text="*"></asp:RequiredFieldValidator>
        </div>

        <%-- Confirmación de contraseña: tiene que coincidir con la anterior --%>
        <div class="campo">
            <label for="<%= txtConfirmar.ClientID %>">Confirmar contraseña</label>
            <asp:TextBox ID="txtConfirmar" runat="server" TextMode="Password" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvConfirmar" runat="server"
                ControlToValidate="txtConfirmar" CssClass="error" Display="Dynamic"
                ErrorMessage="Confirmá la contraseña" Text="*"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvConfirmar" runat="server"
                ControlToValidate="txtConfirmar" ControlToCompare="txtPassword"
                Operator="Equal" Type="String"
                CssClass="error" Display="Dynamic"
                ErrorMessage="Las contraseñas no coinciden" Text="*"></asp:CompareValidator>
        </div>

        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar"
            CssClass="boton" OnClick="btnRegistrar_Click" />

        <%-- Mensaje de resultado --%>
        <asp:Panel ID="pnlExito" runat="server" Visible="false" CssClass="mensaje-exito">
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            <br />
            <asp:HyperLink ID="lnkIrLogin" runat="server" NavigateUrl="~/Login.aspx">
                Ir a iniciar sesión
            </asp:HyperLink>
        </asp:Panel>
    </div>

</asp:Content>