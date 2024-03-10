package com.skilldistillery.dragonscrown.controllers;

import java.net.URI;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.client.WebClient;


@RestController
public class ImageProxyController {

    private final WebClient webClient = WebClient.create();

    @GetMapping("/api/proxy/image")
    public ResponseEntity<?> fetchImage(@RequestParam("url") String url) {
        try {
            return webClient.get()
                    .uri(URI.create(url))
                    .retrieve()
                    .toEntity(byte[].class)
                    .map(response -> ResponseEntity.ok()
                            .contentType(MediaType.IMAGE_JPEG) // Adjust based on the actual content type
                            .body(response.getBody()))
                    .block(); // For demonstration; consider using async handling
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to fetch image");
        }
    }
}
