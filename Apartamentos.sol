pragma solidity ^0.5.9;




contract Cerradura {
    
     
    struct Alquiler {
        bool pagado;
        bool desbloqueada;
        uint16 precio;
        uint256 duracion;
        uint256 horaSalida;
        uint256 ahora;
    }
    
    
    uint8 AlquilerID=0;
    
    
    mapping (uint8 => Alquiler) public alquileres;
    
    
    function ofrecerAlquiler(uint16 price, uint16 tiempo) public {
        
        alquileres[AlquilerID].precio = price;
        alquileres[AlquilerID].duracion = tiempo;
        alquileres[AlquilerID].pagado = false;
        alquileres[AlquilerID].desbloqueada = false;
        AlquilerID++;
        
    }
    
    
    function pagarAlquiler(uint8 id)  public  payable{
        
    require(msg.value == alquileres[id].precio);
        alquileres[id].pagado=true;
        alquileres[id].horaSalida = now + (alquileres[id].duracion * 1 seconds);
        alquileres[id].desbloqueada=true;
    }


    function cancelarAlquiler(uint8 id)  public  {
        
        alquileres[id].desbloqueada=false;

    }
    
    
     function finalizarAlquiler(uint8 id)  public  {
        require(now >  alquileres[id].horaSalida);
        alquileres[id].desbloqueada=false;

    }
    
    function getDesbloqueada()public returns (bool){
        return alquileres[0].desbloqueada;
    }
   
     function getNow() public {
        alquileres[0].ahora=now;
    }
    
  

}
