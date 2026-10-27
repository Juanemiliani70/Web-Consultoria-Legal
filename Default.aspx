<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Parcial2_LP3._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContenido" runat="server">

    <%-- Banner con las imágenes de la empresa --%>
    <asp:Image ID="imgBanner" runat="server" CssClass="banner"
        ImageUrl="~/Images/banner.png" AlternateText="Asesoría Legal Global" />

    <div class="tarjeta" style="margin-top: 20px;">
        <h2>Bienvenido a Asesoría Legal Global</h2>
        <p>
            Ofrecemos servicios de asesoramiento en temas legales. Registrate para
            gestionar tus documentos legales de manera segura.
        </p>
        <asp:Image ID="imgLogoBlanco" runat="server" CssClass="logo-centrado"
            ImageUrl="~/Images/logo-blanco.png" AlternateText="Logo de la empresa" />
    </div>

</asp:Content>