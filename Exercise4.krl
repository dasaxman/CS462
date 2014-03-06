ruleset foursquare {
    meta {
        name "Foursquare Exercise"
        description <<
            Foursquare
        >>
        author "Riley Monson"
        logging off
    }
    rule HelloWorld is active {
        select when web cloudAppSelected
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Foursquare", {}, "<div id='content'>Hey, content here</div>");
        }
    }
}
