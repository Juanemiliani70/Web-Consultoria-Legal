<%@ Page Title="Mis documentos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Documentos.aspx.cs" Inherits="Parcial2_LP3.Documentos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContenido" runat="server">

    <%-- Encabezado del espacio personal --%>
    <div class="tarjeta">
        <h2>Mis documentos</h2>
        <asp:Label ID="lblBienvenida" runat="server" CssClass="bienvenida"></asp:Label>
        <br /><br />
        <asp:Button ID="btnCerrarSesion" runat="server" Text="Cerrar sesión"
            CssClass="boton boton-secundario" CausesValidation="false"
            OnClick="btnCerrarSesion_Click" />
    </div>

    <%-- Subida de documentos --%>
    <div class="tarjeta">
        <h2>Cargar documento</h2>
        <p>Formatos permitidos: PDF, Word, TXT, JPG y PNG. Tamaño máximo: 5 MB.</p>

        <asp:FileUpload ID="fuDocumento" runat="server" CssClass="archivo" />
        <br /><br />
        <asp:Button ID="btnSubir" runat="server" Text="Subir documento"
            CssClass="boton" OnClick="btnSubir_Click" />

        <%-- Mensaje de resultado (verde si salió bien, rojo si hubo error) --%>
        <asp:Label ID="lblResultado" runat="server" Visible="false"></asp:Label>
    </div>

    <%-- Lista de documentos ya cargados --%>
    <div class="tarjeta">
        <h2>Documentos cargados</h2>

        <asp:GridView ID="gvDocumentos" runat="server"
            AutoGenerateColumns="False"
            CssClass="tabla"
            GridLines="None"
            OnRowCommand="gvDocumentos_RowCommand"
            EmptyDataText="Todavía no cargaste ningún documento.">
            <Columns>
                <asp:BoundField DataField="Nombre" HeaderText="Archivo" />
                <asp:BoundField DataField="Tamano" HeaderText="Tamaño" />
                <asp:BoundField DataField="Fecha" HeaderText="Fecha de carga" />
                <asp:TemplateField HeaderText="Acción">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnDescargar" runat="server"
                            CommandName="Descargar"
                            CommandArgument='<%# Eval("Nombre") %>'
                            CausesValidation="false">Descargar</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>