ruleset foursquare {
    meta {
        name "Foursquare Exercise"
        description <<
            Foursquare
        >>
        author "Riley Monson"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    rule display_checkin {
        select when web cloudAppSelected
        pre {
            my_html = <<
              <div id="content">
                Venue:#{ent:venue}<br>
                City:#{ent:city}<br>
                Shout:#{ent:shout}<br>
                Created:#{ent:created}
              </div>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Foursquare", {}, my_html);
        }
    }
    
    rule process_fs_checkin {
        select when foursquare checkin
        pre {
            fs_event = event:attr("checkin");
            venue = event:attr("checkin").decode().pick("$.venue.name");
            city = event:attr("checkin").decode().pick("$.venue.location.city");
            shout = event:attr("checkin").decode().pick("$.shout");
            created = event:attr("checkin").decode().pick("$.createdAt");
        }
        send_directive(venue) with body = {"checkin" : venue};
        fired {
            set ent:venue venue;
            set ent:city city;
            set ent:shout shout;
            set ent:created created;
            raise pds event 'new_location_data' attributes {"key": "checkin",
                                                          "value" : { "venue" : ent:venue,
                                                                      "city" : ent:city,
                                                                      "shout" : ent:shout,
                                                                      "created" : ent:created}};
        }
    }
}
