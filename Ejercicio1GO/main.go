package main

import (
	"fmt"
	"sort"
)

// Definición de un artículo en el inventario
type Articulo struct {
	descripcion string
	stock       int
	costo       int
}

// Colección de artículos
type Inventario []Articulo

var stockProductos Inventario

const minimoStock int = 10

// Agregar un artículo o actualizarlo si ya existe
func (inv *Inventario) anadirArticulo(desc string, stock int, costo int) {
	if item, encontrado := inv.encontraryActualizarArticulo(desc); encontrado {
		item.stock += stock
		if item.costo != costo {
			item.costo = costo
		}
	} else {
		*inv = append(*inv, Articulo{descripcion: desc, stock: stock, costo: costo})
	}
}

// Inicializa el inventario con algunos artículos
func inicializarStock() {
	productosIniciales := []Articulo{
		{"arroz", 15, 2500},
		{"frijoles", 4, 2000},
		{"leche", 8, 1200},
		{"café", 12, 4500},
	}
	for _, articulo := range productosIniciales {
		stockProductos.anadirArticulo(articulo.descripcion, articulo.stock, articulo.costo)
	}
}

// Busca un artículo por su descripción y devuelve el artículo y un bool si se encontró
func (inv *Inventario) encontraryActualizarArticulo(desc string) (*Articulo, bool) {
	for i := range *inv {
		if (*inv)[i].descripcion == desc {
			return &(*inv)[i], true
		}
	}
	return nil, false
}

// Vende un artículo y lo elimina si el stock llega a cero
func (inv *Inventario) venderArticulo(desc string, cantidad int) {
	if item, encontrado := inv.encontraryActualizarArticulo(desc); encontrado {
		if item.stock >= cantidad {
			item.stock -= cantidad
			if item.stock == 0 {
				inv.removerArticulo(desc)
				fmt.Printf("Artículo %s vendido completamente y eliminado del inventario.\n", desc)
			}
		} else {
			fmt.Println("Stock insuficiente para la venta.")
		}
	} else {
		fmt.Println("Artículo no encontrado en el inventario.")
	}
}

// Elimina un artículo del inventario
func (inv *Inventario) removerArticulo(desc string) {
	for i, item := range *inv {
		if item.descripcion == desc {
			*inv = append((*inv)[:i], (*inv)[i+1:]...)
			break
		}
	}
}

// Lista artículos con stock igual o menor al mínimo
func (inv *Inventario) articulosBajoStock() Inventario {
	var resultado Inventario
	for _, item := range *inv {
		if item.stock <= minimoStock {
			resultado = append(resultado, item)
		}
	}
	return resultado
}

// Aumenta el stock de artículos bajo el mínimo
func (inv *Inventario) reponerStock(bajos Inventario) {
	for _, item := range bajos {
		necesario := minimoStock - item.stock
		if necesario > 0 {
			inv.anadirArticulo(item.descripcion, necesario, item.costo)
			fmt.Printf("Se reponen %d unidades de %s.\n", necesario, item.descripcion)
		}
	}
}

// Ordena los artículos por diferentes criterios
func (inv *Inventario) ordenarPor(criterio string) {
	switch criterio {
	case "descripcion":
		sort.Slice(*inv, func(i, j int) bool { return (*inv)[i].descripcion < (*inv)[j].descripcion })
	case "stock":
		sort.Slice(*inv, func(i, j int) bool { return (*inv)[i].stock < (*inv)[j].stock })
	case "costo":
		sort.Slice(*inv, func(i, j int) bool { return (*inv)[i].costo < (*inv)[j].costo })
	default:
		fmt.Println("Criterio de ordenamiento no válido")
	}
}

// Imprime el inventario en un formato tabular
func imprimirInventario(inventario Inventario, mensaje string) {
	fmt.Println(mensaje)
	fmt.Println("Descripción\tStock\tCosto")
	for _, item := range inventario {
		fmt.Printf("%-12s\t%d\t%d\n", item.descripcion, item.stock, item.costo)
	}
	fmt.Println()
}

func main() {
	inicializarStock()
	imprimirInventario(stockProductos, "Inventario inicial:")

	stockProductos.venderArticulo("arroz", 2)
	stockProductos.venderArticulo("frijoles", 3)
	stockProductos.venderArticulo("café", 5)
	imprimirInventario(stockProductos, "Inventario después de ventas:")

	articulosMinimos := stockProductos.articulosBajoStock()
	imprimirInventario(articulosMinimos, "Artículos con stock mínimo:")

	stockProductos.reponerStock(articulosMinimos)
	imprimirInventario(stockProductos, "Inventario después de reponer stock:")

	fmt.Println("Ordenando por descripción:")
	stockProductos.ordenarPor("descripcion")
	imprimirInventario(stockProductos, "Inventario ordenado por descripción:")

	fmt.Println("Ordenando por stock:")
	stockProductos.ordenarPor("stock")
	imprimirInventario(stockProductos, "Inventario ordenado por stock:")

	fmt.Println("Ordenando por costo:")
	stockProductos.ordenarPor("costo")
	imprimirInventario(stockProductos, "Inventario ordenado por costo:")
}
