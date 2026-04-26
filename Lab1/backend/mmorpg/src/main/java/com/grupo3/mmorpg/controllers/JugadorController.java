package com.grupo3.mmorpg.controllers;

import com.grupo3.mmorpg.models.Jugador;
import com.grupo3.mmorpg.services.JugadorService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller REST para operaciones con Jugadores
 * Endpoints: /api/jugadores
 */
@RestController
@RequestMapping("/api/jugadores")
public class JugadorController {
    
    private final JugadorService jugadorService;
    
    public JugadorController(JugadorService jugadorService) {
        this.jugadorService = jugadorService;
    }
    
    // ============================================================================
    // CRUD BÁSICOS
    // ============================================================================
    
    /**
     * Crea un nuevo jugador
     * POST /api/jugadores
     * @param jugador Objeto Jugador con los datos
     * @return ResponseEntity con el jugador creado
     */
    @PostMapping
    public ResponseEntity<Jugador> crearJugador(@RequestBody Jugador jugador) {
        try {
            jugadorService.crearJugador(jugador);
            return ResponseEntity.status(HttpStatus.CREATED).body(jugador);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(null);
        }
    }
    
    /**
     * Obtiene todos los jugadores
     * GET /api/jugadores
     * @return Lista de jugadores
     */
    @GetMapping
    public List<Jugador> obtenerTodosLosJugadores() {
        return jugadorService.obtenerTodosLosJugadores();
    }
    
    /**
     * Obtiene un jugador por su ID
     * GET /api/jugadores/{id}
     * @param id ID del jugador
     * @return ResponseEntity con el jugador o 404
     */
    @GetMapping("/{id}")
    public ResponseEntity<Jugador> obtenerJugador(@PathVariable Long id) {
        return jugadorService.obtenerJugador(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    /**
     * Actualiza un jugador existente
     * PUT /api/jugadores/{id}
     * @param id ID del jugador
     * @param jugador Objeto Jugador con los datos actualizados
     * @return ResponseEntity con el jugador actualizado o 404
     */
    @PutMapping("/{id}")
    public ResponseEntity<Jugador> actualizarJugador(@PathVariable Long id, @RequestBody Jugador jugador) {
        jugador.setId_jugador(id);
        try {
            jugadorService.actualizarJugador(jugador);
            return ResponseEntity.ok(jugador);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }
    
    /**
     * Elimina un jugador por su ID
     * DELETE /api/jugadores/{id}
     * @param id ID del jugador
     * @return ResponseEntity con status 204 o 404
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarJugador(@PathVariable Long id) {
        try {
            jugadorService.eliminarJugador(id);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
    
    // ============================================================================
    // MÉTODOS ESPECÍFICOS
    // ============================================================================
    
    /**
     * Busca un jugador por username
     * GET /api/jugadores/username/{username}
     * @param username Nombre de usuario
     * @return ResponseEntity con el jugador o 404
     */
    @GetMapping("/username/{username}")
    public ResponseEntity<Jugador> buscarPorUsername(@PathVariable String username) {
        return jugadorService.buscarPorUsername(username)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    /**
     * Verifica si un username existe
     * GET /api/jugadores/exists/{username}
     * @param username Nombre de usuario
     * @return true si existe, false en caso contrario
     */
    @GetMapping("/exists/{username}")
    public ResponseEntity<Boolean> existeUsername(@PathVariable String username) {
        return ResponseEntity.ok(jugadorService.existeUsername(username));
    }
}