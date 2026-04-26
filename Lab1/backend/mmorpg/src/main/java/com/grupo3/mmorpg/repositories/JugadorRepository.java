package com.grupo3.mmorpg.repositories;

import com.grupo3.mmorpg.models.Jugador;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

/**
 * Repositorio para operaciones JDBC con la tabla Jugador
 * Utiliza JdbcTemplate para ejecutar consultas SQL
 */
@Repository
public class JugadorRepository {
    
    private final JdbcTemplate jdbcTemplate;
    
    // RowMapper para mapear resultados de ResultSet a objetos Jugador
    private static final RowMapper<Jugador> JUGADOR_ROW_MAPPER = (rs, rowNum) -> {
        Jugador jugador = new Jugador();
        jugador.setId_jugador(rs.getLong("id_jugador"));
        jugador.setUsername(rs.getString("username"));
        jugador.setPassword(rs.getString("password"));
        jugador.setRol(rs.getString("rol"));
        return jugador;
    };
    
    public JugadorRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    // ============================================================================
    // CRUD BÁSICOS
    // ============================================================================
    
    /**
     * Crea un nuevo jugador en la base de datos
     * INSERT INTO Jugador (username, password, rol) VALUES (?, ?, ?)
     */
    public int create(Jugador jugador) {
        String sql = "INSERT INTO Jugador (username, password, rol) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, 
            jugador.getUsername(), 
            jugador.getPassword(), 
            jugador.getRol()
        );
    }
    
    /**
     * Busca un jugador por su ID
     * SELECT * FROM Jugador WHERE id_jugador = ?
     */
    public Optional<Jugador> findById(Long id) {
        String sql = "SELECT * FROM Jugador WHERE id_jugador = ?";
        List<Jugador> result = jdbcTemplate.query(sql, new Object[]{id}, JUGADOR_ROW_MAPPER);
        return result.isEmpty() ? Optional.empty() : Optional.of(result.get(0));
    }
    
    /**
     * Obtiene todos los jugadores
     * SELECT * FROM Jugador ORDER BY id_jugador
     */
    public List<Jugador> findAll() {
        String sql = "SELECT * FROM Jugador ORDER BY id_jugador";
        return jdbcTemplate.query(sql, JUGADOR_ROW_MAPPER);
    }
    
    /**
     * Actualiza un jugador existente
     * UPDATE Jugador SET username = ?, password = ?, rol = ? WHERE id_jugador = ?
     */
    public int update(Jugador jugador) {
        String sql = "UPDATE Jugador SET username = ?, password = ?, rol = ? WHERE id_jugador = ?";
        return jdbcTemplate.update(sql,
            jugador.getUsername(),
            jugador.getPassword(),
            jugador.getRol(),
            jugador.getId_jugador()
        );
    }
    
    /**
     * Elimina un jugador por su ID
     * DELETE FROM Jugador WHERE id_jugador = ?
     */
    public int deleteById(Long id) {
        String sql = "DELETE FROM Jugador WHERE id_jugador = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    // ============================================================================
    // MÉTODOS ESPECÍFICOS
    // ============================================================================
    
    /**
     * Busca un jugador por su nombre de usuario
     * SELECT * FROM Jugador WHERE username = ?
     * Útil para autenticación
     */
    public Optional<Jugador> findByUsername(String username) {
        String sql = "SELECT * FROM Jugador WHERE username = ?";
        List<Jugador> result = jdbcTemplate.query(sql, new Object[]{username}, JUGADOR_ROW_MAPPER);
        return result.isEmpty() ? Optional.empty() : Optional.of(result.get(0));
    }
    
    /**
     * Verifica si un username ya existe
     * SELECT COUNT(*) FROM Jugador WHERE username = ?
     */
    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM Jugador WHERE username = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{username}, Integer.class);
        return count != null && count > 0;
    }
}