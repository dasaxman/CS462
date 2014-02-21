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
        {
            html = <<
                            <p>Here is my paragraph text. How lame is this?</p><br>
                            <label for="firstName">First Name</label><input id="firstName" name="firstName"><br>
                            <label for="lastName">Last Name</label><input id="lastName" name="lastName"><br>
                            <input type="submit" id="formSubmit">
                            >>;
            append("#main", html);
        }
    }
}
