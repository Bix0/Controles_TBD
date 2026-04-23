
import { useState } from 'react';
import RaidFilterBar from './components/RaidFilterBar';

function App() {
  const [Rolfiltro, setRolfiltro] = useState('Todos');
  const [Ilvfiltro, setIlvfiltro] = useState(0);

  const [raids, setRaids] = useState([
    { id:1, nombre: 'Cripta de las sombra', reqIlv: 150, cupos: {tanque: 1, healer: 2, dps: 5} },
    { id:2, nombre: 'Asalto a Ulduar', reqIlv: 180, cupos: {tanque: 1, healer: 2, dps: 5} },
    { id:3, nombre: 'Ciudadela del Fuego Infernal', reqIlv: 200, cupos: {tanque: 1, healer: 2, dps: 5} },
    { id:4, nombre: 'Templo Oscuro', reqIlv: 170, cupos: {tanque: 1, healer: 2, dps: 5} },
    { id:5, nombre: 'Corona de Hielo', reqIlv: 190, cupos: {tanque: 1, healer: 2, dps: 5} },
    { id:6, nombre: 'Bastión del Crepúsculo', reqIlv: 160, cupos: {tanque: 1, healer: 2, dps: 5} },
    { id:7, nombre: 'Guarida de Alanegra', reqIlv: 155, cupos: {tanque: 1, healer: 2, dps: 5} },
    { id:8, nombre: 'Cámaras de Reflexión', reqIlv: 165, cupos: {tanque: 1, healer: 2, dps: 5} },
    { id:9, nombre: 'Bastión Violeta', reqIlv: 175, cupos: {tanque: 1, healer: 2, dps: 5} },
    { id:10, nombre: 'Sagrario de la Tempestad', reqIlv: 185, cupos: {tanque: 1, healer: 2, dps: 5} }
  ]);

  return (
    <div style={{ fontFamily: 'arial', maxWidth: '800px', margin: '0 auto' }}>
      <RaidFilterBar 
        rolFiltro={Rolfiltro} 
        setRolFiltro={setRolfiltro} 
        ilvlFiltro={Ilvfiltro} 
        setIlvlFiltro={setIlvfiltro} 
      /> 

      {/* El mapeo y renderizado de las Raids irá aquí en el paso 3 */}
      <div>
        <p> Raids cargadas en memoria: {raids.length} </p>
        <p> Filtro actual: Rol {Rolfiltro} | Item Level: {Ilvfiltro} </p>
      </div>
    </div>
  );
}

export default App;