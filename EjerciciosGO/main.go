package main

import (
	"fmt"
	"sort"
	"strings"
)

type infoCliente struct {
	nombre string
	correo string
	edad   int32
}

type listaClientes []infoCliente

func (lc *listaClientes) agregarCliente(nombre, correo string, edad int32) {
	*lc = append(*lc, infoCliente{nombre, correo, edad})
}

func (lc listaClientes) String() string {
	var sb strings.Builder
	for _, cliente := range lc {
		sb.WriteString(fmt.Sprintf("%s (%d) - %s\n", cliente.nombre, cliente.edad, cliente.correo))
	}
	return sb.String()
}

func filter[T any](list []T, fn func(T) bool) []T {
	var result []T
	for _, v := range list {
		if fn(v) {
			result = append(result, v)
		}
	}
	return result
}

func mapFn[T, U any](list []T, fn func(T) U) []U {
	var result []U
	for _, v := range list {
		result = append(result, fn(v))
	}
	return result
}

func reduce[T, U any](list []T, fn func(U, T) U, initial U) U {
	result := initial
	for _, v := range list {
		result = fn(result, v)
	}
	return result
}

func (lc listaClientes) listaClientes_ApellidoEnCorreo() listaClientes {
	return filter(lc, func(cliente infoCliente) bool {
		apellido := strings.Split(cliente.nombre, " ")[1]
		return strings.Contains(strings.ToLower(cliente.correo), strings.ToLower(apellido))
	})
}

func (lc listaClientes) cantidadCorreosCostaRica() int {
	return reduce(lc, func(acc int, cliente infoCliente) int {
		if strings.HasSuffix(cliente.correo, ".cr") {
			return acc + 1
		}
		return acc
	}, 0)
}

func (lc listaClientes) clientesSugerenciasCorreos() listaClientes {
	return mapFn(lc, func(cliente infoCliente) infoCliente {
		nombrePartes := strings.Fields(strings.ToLower(cliente.nombre))
		if strings.Contains(strings.ToLower(cliente.correo), nombrePartes[0]) && strings.Contains(strings.ToLower(cliente.correo), nombrePartes[1]) {
			return cliente
		}
		// Sugerir un nuevo correo
		sugerencia := fmt.Sprintf("%s.%s@gmail.com", nombrePartes[0], nombrePartes[1])
		return infoCliente{nombre: cliente.nombre, correo: sugerencia, edad: cliente.edad}
	})
}

func (lc listaClientes) correosOrdenadosAlfabeticos() []string {
	correos := mapFn(lc, func(cliente infoCliente) string {
		return cliente.correo
	})
	sort.Strings(correos)
	return correos
}

func main() {
	var lista listaClientes
	fmt.Println("================================")
	fmt.Println("Ejercicio1")
	fmt.Println("================================")
	lista.agregarCliente("Oscar Viquez", "oviquez@tec.ac.cr", 44)
	lista.agregarCliente("Pedro Perez", "elsegundo@gmail.com", 30)
	lista.agregarCliente("Maria Lopez", "mlopez@hotmail.com", 18)
	lista.agregarCliente("Juan Rodriguez", "jrodriguez@gmail.com", 25)
	lista.agregarCliente("Luisa Gonzalez", "muyseguro@tec.ac.cr", 67)
	lista.agregarCliente("Marco Rojas", "loquesea@hotmail.com", 47)
	lista.agregarCliente("Marta Saborio", "msaborio@gmail.com", 33)
	lista.agregarCliente("Camila Segura", "csegura@ice.co.cr", 19)
	lista.agregarCliente("Fernando Rojas", "frojas@estado.gov", 27)
	lista.agregarCliente("Rosa Ramirez", "risuenna@gmail.com", 50)

	fmt.Println("Lista original de clientes:")
	fmt.Println(lista)

	fmt.Println("================================")
	fmt.Println("Ejercicio2")
	fmt.Println("================================")
	
	fmt.Println("\nClientes con apellido en su correo:")
	clientesApellidoEnCorreo := lista.listaClientes_ApellidoEnCorreo()
	fmt.Println(clientesApellidoEnCorreo)

	fmt.Println("================================")
	fmt.Println("Ejercicio3")
	fmt.Println("================================")

	fmt.Println("\nCantidad de correos de Costa Rica:")
	cantidadCorreosCR := lista.cantidadCorreosCostaRica()
	fmt.Println(cantidadCorreosCR)

	fmt.Println("================================")
	fmt.Println("Ejercicio4")
	fmt.Println("================================")
	
	fmt.Println("\nClientes con sugerencias de correos:")
	clientesSugerencias := lista.clientesSugerenciasCorreos()
	fmt.Println(clientesSugerencias)

	fmt.Println("================================")
	fmt.Println("Ejercicio5")
	fmt.Println("================================")
	fmt.Println("\nCorreos ordenados alfabéticamente:")
	correosOrdenados := lista.correosOrdenadosAlfabeticos()
	for _, correo := range correosOrdenados {
		fmt.Println(correo)
	}
}

