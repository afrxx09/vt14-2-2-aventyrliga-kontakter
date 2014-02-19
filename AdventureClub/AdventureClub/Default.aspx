<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AdventureClub.Default" ViewStateMode="Disabled" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="Scripts/jquery-2.1.0.min.js"></script>
    <link href="~/Styles/style.css" rel="stylesheet" />
    <title>Adventure Club</title>
</head>
<body>
    <div id="wrap">
        <div id="header">
            <h1>Adventure Club!</h1>
            <p>Medlemsregister</p>
        </div>
        <div id="content">
            <form id="form1" runat="server">
                <%--
                <div id="NewContactForm">
                    <div class="formrow">
                        <asp:Label ID="lblFirstName" runat="server" AssociatedControlID="txtFirstName">Förnamn</asp:Label>
                        <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Får inte lämnas tom." ControlToValidate="txtFirstName" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                    </div>
                    <div class="formrow">
                        <asp:Label ID="lblLastName" runat="server" AssociatedControlID="txtLastName">Efternamn</asp:Label>
                        <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Får inte lämnas tom." ControlToValidate="txtLastName" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                    </div>
                    <div class="formrow">
                        <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail">Epost</asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Får inte lämnas tom." ControlToValidate="txtEmail" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Ingen giltig E-postadress" ControlToValidate="txtEmail" Display="Dynamic" Text="*" ValidationExpression="(?i:^[a-z0-9]+\@[a-z0-9]+\.[a-z]{2,4}$)"></asp:RegularExpressionValidator>
                    </div>
                    <div class="formrow">
                        <asp:Button ID="btnAddContact" runat="server" Text="Lägg till ny kontakt" OnClick="btnAddContact_Click" />
                    </div>
                </div>
                --%>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                <asp:GridView ID="GridView1" runat="server"></asp:GridView>
                <asp:ListView ID="ListView1" runat="server"
                    ItemType="AdventureClub.Model.Contact"
                    SelectMethod="ListView1_GetData"
                    DeleteMethod="ListView1_DeleteItem"
                    UpdateMethod="ListView1_UpdateItem"
                    InsertMethod="ListView1_InsertItem"
                    AllowPaging="true"
                    PageSize="5"
                    InsertItemPosition="FirstItem"
                    DataKeyNames="ContactId">
                    <LayoutTemplate>
                        <div id="ContactContainer">
                            <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                        </div>
                    </LayoutTemplate>
                    <InsertItemTemplate>
                        <div class="formrow">
                            <asp:Label ID="lblFirstName" runat="server" AssociatedControlID="FirstName">Förnamn</asp:Label>
                            <asp:TextBox ID="FirstName" runat="server" Text='<%# BindItem.FirstName %>' />
                            
                        </div>
                        <div class="formrow">
                            <asp:Label ID="lblLastName" runat="server" AssociatedControlID="LastName">Efternamn</asp:Label>
                            <asp:TextBox ID="LastName" runat="server" Text='<%# BindItem.LastName %>' />
                        </div>
                        <div class="formrow">
                            <asp:Label ID="lblEmail" runat="server" AssociatedControlID="Email">Epost</asp:Label>
                            <asp:TextBox ID="Email" runat="server" Text='<%# BindItem.Email %>' /> 
                        </div>
                        <div class="formrow">
                            <asp:LinkButton runat="server" CommandName="Insert" Text="Lägg till ny Kontakt" CausesValidation="false" />
                        </div>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Får inte lämnas tom." ControlToValidate="Email" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Ingen giltig E-postadress" ControlToValidate="Email" Display="Dynamic" Text="*" ValidationExpression="(?i:^[a-z0-9]+\@[a-z0-9]+\.[a-z]{2,4}$)"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Får inte lämnas tom." ControlToValidate="FirstName" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Får inte lämnas tom." ControlToValidate="LastName" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>

                    </InsertItemTemplate>
                    <ItemTemplate>
                        <div class="ContactRow">
                            <div class="ContactCol FirstName"><%# Item.FirstName %></div>
                            <div class="ContactCol LastName"><%# Item.LastName %></div>
                            <div class="ContactCol Email"><%# Item.Email %></div>
                            <div class="ContactCol Options">
                                <asp:LinkButton runat="server" CommandName="Edit" Text="E" CausesValidation="false" />
                                <asp:LinkButton runat="server" CommandName="Delete" Text="D" CausesValidation="false" />
                            </div>
                        </div>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <div class="ContactCol FirstName">
                            <asp:TextBox ID="FirstName" runat="server" Text='<%# BindItem.FirstName %>'></asp:TextBox>
                        </div>
                        <div class="ContactCol LastName">
                            <asp:TextBox ID="LastName" runat="server" Text='<%# BindItem.LastName %>'></asp:TextBox>
                        </div>
                        <div class="ContactCol Email">
                            <asp:TextBox ID="Email" runat="server" Text='<%# BindItem.Email %>'></asp:TextBox>
                        </div>
                        <div class="ContactCol">
                            <asp:LinkButton runat="server" CommandName="Update" Text="S" />
                            <asp:LinkButton runat="server" CommandName="Cancel" Text="A" CausesValidation="false" />
                        </div>
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Får inte lämnas tom." ControlToValidate="Email" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Ingen giltig E-postadress" ControlToValidate="Email" Display="Dynamic" Text="*" ValidationExpression="(?i:^[a-z0-9]+\@[a-z0-9]+\.[a-z]{2,4}$)"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Får inte lämnas tom." ControlToValidate="FirstName" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Får inte lämnas tom." ControlToValidate="LastName" Display="Dynamic" Text="*"></asp:RequiredFieldValidator>

                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <p>Ingen data.</p>
                    </EmptyDataTemplate>
                </asp:ListView>
                <div style="clear: both;"></div>
            </form>
        </div>
        <div id="footer">
            <p>ASP.NET WebForms - lnu</p>
            <p>Laboration 2.2: Adventure Club</p>
            <p>Andreas Fridlund - afrxx09</p>
        </div>
    </div>
</body>
</html>
