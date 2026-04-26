package com.grupo3.mmorpg.services;

import com.grupo3.mmorpg.models.Raid;
import com.grupo3.mmorpg.repositories.RaidRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Servicio para operaciones de negocio relacionadas con Raids
 * Utiliza RaidRepository para acceder a los datos
 * Incluye integración con procedimientos almacenados
 */
@Service
public class RaidService {
    
    private final RaidRepository raidRepository;
    
    public RaidService(RaidRepository raidRepository) {
        this.raidRepository = raidRepository;
    }
    
    // ============================================================================
    // CRUD BÁSICOS
    // ============================================================================
    
    /**
     * Crea una nueva raid
     * @param raid Objeto Raid con los datos a guardar
     * @return Número de filas afectadas (1 si se creó correctamente)
     */
    public int crearRaid(Raid raid) {
        return raidRepository.create(raid);
    }
    
    /**
     * Obtiene una raid por su ID
     * @param id ID de la raid
     * @return Optional con la raid si existe
     */
    public Optional<Raid> obtenerRaid(Long id) {
        return raidRepository.findById(id);
    }
    
    /**
     * Obtiene todas las raids
     * @return Lista de todas las raids
     */
    public List<Raid> obtenerTodasLasRaids() {
        return raidRepository.findAll();
    }
    
    /**
     * Actualiza una raid existente
     * @param raid Objeto Raid con los datos actualizados
     * @return Número de filas afectadas
     */
    public int actualizarRaid(Raid raid) {
        if (!raidRepository.findById(raid.getId_raid()).isPresent()) {
            throw new IllegalArgumentException("Raid no encontrada");
        }
        return raidRepository.update(raid);
    }
    
    /**
     * Cambia el estado de una raid
     * @param idRaid ID de la raid
     * @param estado Nuevo estado (Programada, En curso, Finalizada)
     * @return Número de filas afectadas
     */
    public int cambiarEstadoRaid(Long idRaid, String estado) {
        return raidRepository.updateEstado(idRaid, estado);
    }
    
    /**
     * Elimina una raid por su ID
     * @param id ID de la raid a eliminar
     * @return Número de filas afectadas
     */
    public int eliminarRaid(Long id) {
        return raidRepository.deleteById(id);
    }
    
    // ============================================================================
    // MÉTODOS ESPECÍFICOS
    // ============================================================================
    
    /**
     * Obtiene raids por estado
     * @param estado Estado de la raid
     * @return Lista de raids con ese estado
     */
    public List<Raid> obtenerPorEstado(String estado) {
        return raidRepository.findByEstado(estado);
    }
    
    /**
     * Obtiene raids programadas
     * @return Lista de raids con estado 'Programada'
     */
    public List<Raid> obtenerRaidsProgramadas() {
        return raidRepository.findProgramadas();
    }
    
    /**
     * Crea una raid con inscripción masiva automática
     * Usa el procedimiento almacenado sp_crear_raid_e_invitar
     * @param nombre Nombre de la raid
     * @param fecha Fecha de la raid
     * @param itemLevel Item level requerido
     * @param tanques Cantidad de cupos para tanques
     * @param heals Cantidad de cupos para heals
     * @param dps Cantidad de cupos para DPS
     * @return ID de la raid creada
     */
    public Long crearRaidConInscripcionMasiva(String nombre, LocalDateTime fecha,
                                               Integer itemLevel, Integer tanques,
                                               Integer heals, Integer dps) {
        return raidRepository.crearRaidConInscripcionMasiva(nombre, fecha, itemLevel, tanques, heals, dps);
    }
    
    /**
     * Inscribe un personaje a una raid
     * @param idRaid ID de la raid
     * @param idPersonaje ID del personaje
     * @return Número de filas afectadas
     * Este INSERT activa el trigger trg_validar_ilvl
     */
    public int inscribirPersonaje(Long idRaid, Long idPersonaje) {
        return raidRepository.inscribirPersonaje(idRaid, idPersonaje);
    }
    
    /**
     * Desinscribe un personaje de una raid
     * @param idRaid ID de la raid
     * @param idPersonaje ID del personaje
     * @return Número de filas afectadas
     */
    public int desinscribirPersonaje(Long idRaid, Long idPersonaje) {
        return raidRepository.desinscribirPersonaje(idRaid, idPersonaje);
    }
    
    /**
     * Obtiene las inscripciones de una raid
     * @param idRaid ID de la raid
     * @return Lista de inscripciones con detalles del personaje
     */
    public List<Object[]> obtenerInscripcionesRaid(Long idRaid) {
        return raidRepository.getInscripcionesRaid(idRaid);
    }
    
    /**
     * Cuenta las inscripciones por estado para una raid
     * @param idRaid ID de la raid
     * @return Lista de arrays [estado, count]
     */
    public List<Object[]> contarInscripcionesPorEstado(Long idRaid) {
        return raidRepository.contarInscripcionesPorEstado(idRaid);
    }
}