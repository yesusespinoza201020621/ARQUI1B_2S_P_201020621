.section .data//reservar memoria para mis variables globales

//guardamos memoria inicial y el puntero de memoria osea la direccion de memoria, son mis datos ok
mensaje1:     .ascii "Practica ünica \n"
len1 = . - mensaje1

mensaje2:     .ascii "Yesus Rudy Espinoza Pivaral 201020621 \n"
len2 = . - mensaje2

mensaje3:     .ascii "Calculadora de Numeros enteros en Ensamblador ARM64 desde linux ubuntu \n"
len3 = . - mensaje3

mensaje4:     .ascii "Elige la Operación a Realizar \n"
len4 = . - mensaje4

suma5:     .ascii "opcion 1 Suma \n"
len5 = . - suma5

resta6:     .ascii "Opcion 2 Resta \n"
len6 = . - resta6

multiplicacion7:     .ascii "Opcion 3 multiplicación \n"
len7 = . - multiplicacion7

divionentera8:     .ascii "Opcion 4 division entera \n"
len8 = . - divionentera8

potencia9:     .ascii "Opcion 5 potencia \n"
len9 = . - potencia9

factorial10:     .ascii "Opcion 5 factorial \n"
len10 = . - factorial10

mensajerror:     .ascii "las opciones validas solo las del menu \n"
len11 = . - mensajerror

num1:     .ascii "ingrese numero 1 \n"
len12 = . - num1

num2:     .ascii "ingrese numero 2 \n"
len13 = . - num2


resultadosuma:       .ascii "El resultado de la suma es: "
len14 = . - resultadosuma

newline:    .ascii "\n"

.section .bss
opcion:   .space 2 //almacenar la opcion a elegir
numero1:    .space 10       // Almacén numero 1 que se va a sumar
numero2:    .space 10        //almacena numero 2 que se va a restar
buffer3:    .space 10        // Almacén para el tercer texto
buffer4:    .space 10        // Almacén para el tercer texto
buffer5:    .space 10        // Almacén para el tercer texto

res_txt:    .space 10       // Almacén para el texto del resultado

.section .text
.global _start

//vamos a comenzar
_start:
    mov     x0, #1
    ldr     x1, =mensaje1
    mov     x2, #len1
    mov     x8, #64         // escribir texto
    svc     #0
    
    mov     x0, #1
    ldr     x1, =mensaje2
    mov     x2, #len2
    mov     x8, #64         // escribir texto
    svc     #0

    mov     x0, #1
    ldr     x1, =mensaje3
    mov     x2, #len3
    mov     x8, #64         // escribir texto
    svc     #0


//textos para las operaciones
    mov     x0, #1
    ldr     x1, =mensaje4
    mov     x2, #len4
    mov     x8, #64         // escribir texto
    svc     #0

//texto opcion suma
        mov     x0, #1
    ldr     x1, =suma5
    mov     x2, #len5
    mov     x8, #64         // escribir texto
    svc     #0

//texto opcion resta
    mov     x0, #1
    ldr     x1, =resta6
    mov     x2, #len6
    mov     x8, #64         // escribir texto
    svc     #0

//texto opcion multiplicacion
    mov     x0, #1
    ldr     x1, =multiplicacion7
    mov     x2, #len7
    mov     x8, #64         // escribir texto
    svc     #0

//texto opcion división entera
    mov     x0, #1
    ldr     x1, =divionentera8
    mov     x2, #len8
    mov     x8, #64         // escribir texto
    svc     #0

//texto opcion potencia
    mov     x0, #1
    ldr     x1, =potencia9
    mov     x2, #len9
    mov     x8, #64         // escribir texto
    svc     #0
    //texto opcion factorial
    mov     x0, #1
    ldr     x1, =factorial10
    mov     x2, #len10
    mov     x8, #64         // escribir texto
    svc     #0

       mov     x0, #0
    ldr     x1, =opcion
    mov     x2, #10
    mov     x8, #63         // leer; obtener el valor de la variable como si fuera alto nivel
    svc     #0
    mov     x21, x0   
   

 //aca empieza los if's
    mov x21, x0         // X21 guarda cuántas letras escribió el usuario

    // 1. Cargamos el PRIMER carácter que el usuario escribió en la variable 'opcion'
    ldr x1, =opcion     // Cargamos la dirección de la variable
    ldrb w0, [x1]       // extrae solo el primer carácter ('1')

    // 2. Aplicamos el IF comparando con el carácter '1'
    cmp w0, #'1'        // Compara el carácter guardado con el carácter '1'
    b.ne .L_else        // Si NO es igual, salta a la sección del .L_else

.L_if:
   
    mov     x0, #1
    ldr     x1, =num1
    mov     x2, #len12
    mov     x8, #64         // escribir texto
    svc     #0

    mov     x0, #0
    ldr     x1, =numero1
    mov     x2, #10
    mov     x8, #63         // obtener numero 1
    svc     #0
    mov     x21, x0  //x21 aqui se guarda para convetir a entero

    mov     x0, #1
    ldr     x1, =num2
    mov     x2, #len13
    mov     x8, #64         // escribir texto
    svc     #0

    mov     x0, #0
    ldr     x1, =numero2
    mov     x2, #10
    mov     x8, #63         // obtener numero 2
    svc     #0
    mov     x22, x0   //aca se guarda en memoria para convertir posterior a entero

// -----------------------------------------------------------------
    // 3. Convertir numero 1 de texto a entero matemático (guardado en x19)
    // -----------------------------------------------------------------
    ldr     x0, =numero1
    mov     x1, x21         // longitud
    bl      ascii_to_int
    mov     x19, x0         // x19 = valor del primer número

    // -----------------------------------------------------------------
    // 4. Convertir numero 2 de texto a entero matemático (guardado en x20)
    // -----------------------------------------------------------------
    ldr     x0, =numero2
    mov     x1, x22         // longitud
    bl      ascii_to_int
    mov     x20, x0         // x20 = valor del segundo número


//vamos hacer la suma x5 alli guardamos el resultado 
    //add     x5, x19, x20   //add es para hacer la suma pero lo tengo que pasar a texto para mostrarlo

    b .L_end            // Salta al final para no entrar al else

.L_else:
    // si elige otra opción tira mendaje de rror

      mov     x0, #1
    ldr     x1, =mensajerror
    mov     x2, #len11
    mov     x8, #64         // escribir texto
    svc     #0
    
.L_end:

//necesito crear la funcion entero para que haga la conversión todo es de cero para que se pueda ensamblar
ascii_to_int:
    mov     x2, #0          // x2 acumulador final = 0
    mov     x3, #0          // Índice de posición = 0
    mov     x4, #10         // Multiplicador fijo = 10


//esto es solo para salir
    mov     x0, #0 //para los errores antes de salir
    mov     x8, #93
    svc     #0 //mira a x8 y #93 transmite para salir entiende y sale
