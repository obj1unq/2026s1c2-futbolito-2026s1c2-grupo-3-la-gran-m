/** First Wollok example */
import wollok.game.*

object lionel {
	
	var property position = game.at(3,5)
	var property camiseta = camisetaTitular
	
	method image() {
		return camiseta.image()
	}

	method retroceder() {
		position = game.at(0.max(position.x() - 1), position.y()) 
	}
	
	method avanzar() {
		position = game.at((game.width() - 1).min(position.x() + 1), position.y()) 
	}
	
	method cambiarCamiseta(){
		if(self.position().x()== 0){
		camiseta.cambiarCamisetaLio()
		}
	}
}


object pelota {
	const property image="pelota.png"
	var property position = game.at(5,5)	
}

object camisetaTitular{
	method image() = "lionel-titular.png"

	method cambiarCamisetaLio(){
		lionel.camiseta(camisetaSuplente)
	}

}

object camisetaSuplente{

	method image() = "lionel-suplente.png"

	method cambiarCamisetaLio(){
		lionel.camiseta(camisetaTitular)
	}
}