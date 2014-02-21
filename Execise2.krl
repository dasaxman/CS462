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
            html = <<
                            <p>Here is my paragraph text. How lame is this?</p><br>
                            <form id="myForm">
                            <label for="firstName">First Name</label><input id="firstName" name="firstName"><br>
                            <label for="lastName">Last Name</label><input id="lastName" name="lastName"><br>
                            <input type="submit" id="formSubmit">
                            </form>
                            >>;
        }
        {
            
            append("#main", html); 
            watch("#myForm", "submit");
        }
    }
    rule submit_rule {
        select when web submit "#myForm"
        notify("Submitted", "Yay");
    }
}
