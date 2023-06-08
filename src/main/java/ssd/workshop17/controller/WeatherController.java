package ssd.workshop17.controller;

import java.io.IOException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ssd.model.openweather.Weather;
import ssd.workshop17.service.WeatherService;

@Controller
@RequestMapping(path="/weather")
public class WeatherController {
    @Autowired
    private WeatherService wSvc;


    @GetMapping
    public String getWeather(@RequestParam(required=true) String city,
        @RequestParam(defaultValue = "metric",required=false) String units, Model model) 
        throws IOException{
        Optional<Weather> w = wSvc.getWeather(city, units);
        //w is an optional so You have to get it
        model.addAttribute("weather", w.get());
        return "weather";
    }
}