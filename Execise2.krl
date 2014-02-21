ruleset Exercise2 {
    meta {
        name "Form Exercise"
        author "Riley Monson"
        logging off
    }
    global {
    }
    rule show_form {
        select when pageview ".*"
        pre {
            form = <<
                    <p>Here is my paragraph text. How lame is this?</p><br>
                    <form id="myForm">
                    <label for="firstName">First Name</label><input id="firstName" name="firstName"><br>
                    <label for="lastName">Last Name</label><input id="lastName" name="lastName"><br>
                    <input type="submit" id="formSubmit">
                    </form>
                    >>;
            name = ent:firstName + " " + ent:lastName;
        }
            {
                notify("Yes", "Names");
                 
                
                append("#main", name);
            }
            if ent:firstName == 0 && ent:lastName == 0 then
            {
                notify("No", "Names");
                append("#main", form);
                watch("#myForm", "submit");
            }
    }
    rule submit_rule {
        select when web submit "#myForm"
        noop();
        fired {
            set ent:firstName event:attr("firstName");
            set ent:lastName event:attr("lastName");
        }
    }
    rule clear_data {
        select when pageview url re/clear=1/
        noop();
        fired {
            clear ent:firstName;
            clear ent:lastName;
        }
    }
}
