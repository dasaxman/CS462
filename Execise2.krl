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
            append("#main", "<p>Here is my paragraph text. How lame is this?</p>");
        }
    }
}
