/** First Wollok example */
import wollok.game.*

/* Taquito: Hacer Lionel de un pase atrás al apretar la tecla t: La pelota se mueve 2 posiciones a la izquierda. (o lo máximo que se pueda mover) Tip: usar el método max de los números entre el x actual de la pelota - 2 y 0. Validar que la pelota se encuentre en la misma posición que Lionel. */

object lionel {
	
	var property tableroDeJuego = tablero
	var property position = game.at(3,5)
	var property newPelota = pelota 


	method image() {
		return "lionel-titular.png"
	}

	method retroceder() {
		position = game.at(0.max(position.x() - 1), position.y()) 
	}
	
	method avanzar() {
		position = game.at((game.width() - 1).min(position.x() + 1), position.y()) 
	}
	method patear(){
		if(self.position()==pelota.position()){
			pelota.pateada()
		}
		
	}	

	method tirarTaco() {
		
		if (tableroDeJuego.estanEnMismaPosicion(self.position(),newPelota.position())) {
		  
			 newPelota.taqueteada(izquierda)
		}
	}
	
	method levantar() {
	  
	  if (tableroDeJuego.estanEnMismaPosicion(self.position(),newPelota.position())) {
		  
			newPelota.levantar(arriba)
		}
	}	

}


object pelota {
	
	var property tableroDeJuego = tablero 
	const property image="pelota.png"
	var property position = game.at(5,5)
	method pateada(){
		position = game.at((game.width() - 1).min(position.x() + 3 ), position.y())
	}
	method taquiteada(){
		position = game.at((0.max(position.x()-2)),position.y())
	}

	
	method levantar(direccion) {
		
		const nuevaPosicion = direccion.siguiente(position) //No modifico la position en la primera linea porque volar podría lanzar error
		position = nuevaPosicion //ahora si puedo modificar la posicion

		game.schedule(2000, { self.caer() })	
		
	}	

	method taqueteada(direccion) {
		
		const nuevaPosicion = direccion.siguiente(position) //No modifico la position en la primera linea porque volar podría lanzar error
		
		//position = nuevaPosicion //ahora si puedo modificar la posicion
	
		position = game.at(0.max(position.x() - 2),position.y())
		
	}


	method caer(){

		const siguiente = position.down(1)
		if(self.position().y() > 5){
			position = siguiente
		}
	}

}



object tablero {
  
  method estanEnMismaPosicion(posicionUno,posicionDos){

		return game.onSameCell(posicionUno, posicionDos)
  }


  method validarDentro(position) {
        if (not self.dentro(position)) {
            self.error(position.toString() + " no está dentro del tablero ")
        }
    }

    method dentro(position) {
        return position.x().between(0, game.width() -1) and position.y().between(0, game.height() -1 )
    }

}


object arriba {

    method siguiente(position) {
        const nueva = position.up(1) 
        tablero.validarDentro(nueva)
        return nueva
    }
}

object izquierda{
    
	method siguiente(position) {
        const nueva = position.left(1) 
        tablero.validarDentro(nueva)
        return nueva
    }

}

