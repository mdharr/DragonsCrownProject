package com.skilldistillery.dragonscrown.controllers;

import java.net.URI;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.client.WebClient;


@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class ImageProxyController {

    private final WebClient webClient = WebClient.create();

    @GetMapping("proxy/image")
    public ResponseEntity<?> fetchImage(@RequestParam("url") String url) {
        try {
            return webClient.get()
                    .uri(URI.create(url))
                    .retrieve()
                    .bodyToMono(byte[].class)
                    .map(body -> ResponseEntity.ok()
                            .contentType(MediaType.IMAGE_JPEG) // You might need to adjust this
                            .body(body))
                    .block(); // Consider handling this asynchronously
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to fetch image");
        }
    }
}
