using AdventureClub.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AdventureClub
{
    public partial class Default : System.Web.UI.Page
    {
        private Service _service;
        private Service Service { get { return _service ?? (_service = new Service()); } }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IEnumerable<Contact> ListView1_GetData()
        {
            return Service.GetContacts();
        }

        /*
        protected void btnAddContact_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    Contact c = new Contact
                    {
                        FirstName = txtFirstName.Text,
                        LastName = txtLastName.Text,
                        Email = txtEmail.Text
                    };
                    Service.SaveContact(c);
                }
                catch
                {
                    throw new Exception();
                }
            }
        }
        */

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListView1_DeleteItem(int contactId)
        {
            try
            {
                Service.DeleteContact(contactId);
            }
            catch
            {
                ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade när kontakten skulle tas bort.");
            }
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListView1_UpdateItem(int contactId)
        {
            try
            {
                var c = Service.GetContact(contactId);
                if (c == null)
                {
                    ModelState.AddModelError(String.Empty, "Kunde inte hitta kontakten och därmed inte heller redigera den.");
                    return;
                }
                if (TryUpdateModel(c))
                {
                    Service.SaveContact(c);
                }
            }
            catch
            {
                ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade när kontakten skulle redigeras.");
            }
        }

        public void ListView1_InsertItem(Contact c)
        {
            try
            {
                Service.SaveContact(c);
            }
            catch
            {
                ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade när kontakten skulle läggas till.");
            }
        }

    }
}