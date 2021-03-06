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
    global {
        subscriptions = {
            "channel1" : {"cid": "D633A7B2-B4AC-11E3-81E5-4D01293232C8"},
            "channel2" : {"cid": "3C41BC38-B4AD-11E3-AA79-3982D61CF0AC"}
        };
    }
    rule display_checkin {
        select when web cloudAppSelected
        pre {
            my_html = <<
              <div id="content">
                Event:#{ent:event}<br>
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
            lat = event:attr("checkin").decode().pick("$.venue.location.lat");
            long = event:attr("checkin").decode().pick("$.venue.location.lng");
        }
        send_directive(venue) with body = {"checkin" : venue};
        fired {
            set ent:event fs_event;
            set ent:venue venue;
            set ent:city city;
            set ent:shout shout;
            set ent:created created;
            raise pds event 'new_location_data' attributes {"key": "checkin",
                                                          "value" : { "venue" : ent:venue,
                                                                      "city" : ent:city,
                                                                      "shout" : ent:shout,
                                                                      "created" : ent:created,
                                                                      "lat" : lat,
                                                                      "long" : long}};
        }
    }
    rule send_events {
        select when foursquare checkin
        foreach subscriptions setting(name, subscription)
        pre {
            fs_event = event:attr("checkin");
            venue = event:attr("checkin").decode().pick("$.venue.name");
            city = event:attr("checkin").decode().pick("$.venue.location.city");
            shout = event:attr("checkin").decode().pick("$.shout");
            created = event:attr("checkin").decode().pick("$.createdAt");
            lat = event:attr("checkin").decode().pick("$.venue.location.lat");
            long = event:attr("checkin").decode().pick("$.venue.location.lng");
        }
        event:send(subscription, "location", "notification")
            with attrs = {
                "venue" : venue,
                "city" : city,
                "shout" : shout,
                "created" : created
                };
    }
}
