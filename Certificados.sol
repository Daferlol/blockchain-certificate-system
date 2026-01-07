// Licencia

// SPDX-License-Identifier: LGPL-3.0-only

//Versión solidity

pragma solidity 0.8.24;

//Contrato
contract Certificados{


//Variables
address public admin;
uint256 public contadorCertificados;

//Struct

struct Certificado {
        uint256 id;
        address estudiante;
        string nombreCurso;
        string nombreEstudiante;
        uint256 fechaEmision;
        bool valido; // Para poder revocar certificados
    }
// Modifiers
modifier soloAdmin() {
        require(msg.sender == admin, "Solo el administrador puede realizar esta accion");
        _;
    }
//mapping

mapping(uint256 => Certificado) public certificados; //mapping para almancenar

mapping(address => uint256[]) public certificadosPorEstudiante; //mapping para ver los certificados de un estudiante
    

//Events
event CertificadoEmitido(
        uint256 indexed id,
        address indexed estudiante,
        string nombreCurso,
        uint256 fechaEmision
        );
    
    event CertificadoRevocado(
        uint256 indexed id,
        address indexed estudiante
    );

    //Constructor
    constructor() {
        admin = msg.sender; // El que despliega el contrato es el admin
        contadorCertificados = 0;
    }


    //emission
function emitirCertificado(
        address _estudiante,
        string memory _nombreCurso,
        string memory _nombreEstudiante
    ) external soloAdmin returns(uint256) {
        require(_estudiante != address(0), "Direccion invalida");
        require(bytes(_nombreCurso).length > 0, "El nombre del curso no puede estar vacio");
        require(bytes(_nombreEstudiante).length > 0, "El nombre del estudiante no puede estar vacio");
        
        contadorCertificados++;
        uint256 nuevoId = contadorCertificados;


         // Crear el certificado
        certificados[nuevoId] = Certificado({
            id: nuevoId,
            estudiante: _estudiante,
            nombreCurso: _nombreCurso,
            nombreEstudiante: _nombreEstudiante,
            fechaEmision: block.timestamp,
            valido: true
        });
        
        // Agregar el ID al array de certificados del estudiante
        certificadosPorEstudiante[_estudiante].push(nuevoId);
        
        emit CertificadoEmitido(nuevoId, _estudiante, _nombreCurso, block.timestamp);
        
        return nuevoId;
    }
    
    // Revoke a certificate
    function revocarCertificado(uint256 _id) external soloAdmin {
        require(_id > 0 && _id <= contadorCertificados, "Certificado no existe");
        require(certificados[_id].valido, "El certificado ya esta revocado");
        
        certificados[_id].valido = false;
        
        emit CertificadoRevocado(_id, certificados[_id].estudiante);
    }
    
    //Internal Functions
    
    //Public Functions
    
    // Check if a certificate is valid
    function verificarCertificado(uint256 _id) public view returns(
        bool existe,
        bool valido,
        string memory nombreCurso,
        string memory nombreEstudiante,
        uint256 fechaEmision,
        address estudiante
    ) {
        if (_id > 0 && _id <= contadorCertificados) {
            Certificado memory cert = certificados[_id];
            return (
                true,
                cert.valido,
                cert.nombreCurso,
                cert.nombreEstudiante,
                cert.fechaEmision,
                cert.estudiante
            );
        }
        return (false, false, "", "", 0, address(0));
    }
    
    // Get all certificate IDs of a student
    function obtenerCertificadosEstudiante(address _estudiante) public view returns(uint256[] memory) {
        return certificadosPorEstudiante[_estudiante];
    }
    
    // change to administrator
    function cambiarAdmin(address _nuevoAdmin) public soloAdmin {
        require(_nuevoAdmin != address(0), "Direccion invalida");
        admin = _nuevoAdmin;
    }
}





  
