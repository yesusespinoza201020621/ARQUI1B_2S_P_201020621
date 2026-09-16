.section .data//reservar memoria para mis variables globales

//guardamos memoria inicial y el puntero de memoria osea la direccion de memoria, son mis datos ok
mensaje1:     .ascii "Practica Única \n"
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

factorial10:     .ascii "Opcion 6 factorial \n"
len10 = . - factorial10

mensajerror:     .ascii "las opciones validas solo las del menu"
len11 = . - mensajerror

num1:     .ascii "ingrese numero 1 \n"
len12 = . - num1

num2:     .ascii "ingrese numero 2 \n"
len13 = . - num2

resultadosuma:       .ascii "El resultado de la suma es: "
len14 = . - resultadosuma

resultadomulti:       .ascii "El resultado de la multiplicación es: "
len15 = . - resultadomulti

resultadoresta:       .ascii "El resultado de la resta es: "
len16 = . - resultadoresta

resultadodiv:         .ascii "El resultado de la división entera es: "
len17 = . - resultadodiv

msg_desea_continuar:  .ascii "¿Desea continuar? (s/n): "
len_continuar = . - msg_desea_continuar

mensajerrordivision:     .ascii "division entre cero no se puede hacer bueno da oo(infinito)"
len18 = . - mensajerrordivision

newline:    .ascii "\n"

.section .bss
opcion:       .space 16 
numero1:      .space 16 
numero2:      .space 16 
res_txt:      .space 16 
resp_cont:    .space 16 // Espacio para guardar la respuesta de continuar (s/n)

.section .text
.global _start

_start:
    // Imprimimos la presentación del programa SOLO UNA VEZ al arrancar
    mov     x0, #1
    ldr     x1, =mensaje1
    mov     x2, #len1
    mov     x8, #64         
    svc     #0
    
    mov     x0, #1
    ldr     x1, =mensaje2
    mov     x2, #len2
    mov     x8, #64         
    svc     #0

    mov     x0, #1
    ldr     x1, =mensaje3
    mov     x2, #len3
    mov     x8, #64         
    svc     #0

//aqui con este este nombre creamos el menu cada vez que sea 's' lo llamamos las veces que sea
.L_menu_loop:

    // Mostrar texto: "Elige la Operación a Realizar"
    mov     x0, #1
    ldr     x1, =mensaje4
    mov     x2, #len4
    mov     x8, #64         
    svc     #0

    // Mostrar las opciones del menú
    mov     x0, #1
    ldr     x1, =suma5
    mov     x2, #len5
    mov     x8, #64         
    svc     #0

    mov     x0, #1
    ldr     x1, =resta6
    mov     x2, #len6
    mov     x8, #64         
    svc     #0

    mov     x0, #1
    ldr     x1, =multiplicacion7
    mov     x2, #len7
    mov     x8, #64         
    svc     #0

    mov     x0, #1
    ldr     x1, =divionentera8
    mov     x2, #len8
    mov     x8, #64         
    svc     #0

    mov     x0, #1
    ldr     x1, =potencia9
    mov     x2, #len9
    mov     x8, #64         
    svc     #0

    mov     x0, #1
    ldr     x1, =factorial10
    mov     x2, #len10
    mov     x8, #64         
    svc     #0

   //espacio de memoria para opción
    mov     x0, #0
    ldr     x1, =opcion
    mov     x2, #10
    mov     x8, #63         
    svc     #0
    mov     x21, x0   

    // aqui guardarmos la opcion en el registro para ver a que operacion
    ldr     x1, =opcion     
    ldrb    w0, [x1]       

    // como el switch case en alto nivel
    cmp     w0, #'1'        
    b.eq    .L_opcion1     

    cmp     w0, #'2'        
    b.eq    .L_opcion2     

    cmp     w0, #'3'        
    b.eq    .L_opcion3     

    cmp     w0, #'4'        
    b.eq    .L_opcion4    

    cmp     w0, #'5'        
    b.eq    .L_opcion5 

    cmp     w0, #'6'        
    b.eq    .L_opcion6 
    
    //si se ingresa otra cosa tira mensaje de error
    b       .L_error

    //me sirve para la division entre cero
    b .L_errordivision
// opciónn1 de la suma
.L_opcion1: 
    mov     x0, #1
    ldr     x1, =num1
    mov     x2, #len12
    mov     x8, #64         
    svc     #0

    mov     x0, #0
    ldr     x1, =numero1
    mov     x2, #10
    mov     x8, #63         
    svc     #0
    mov     x21, x0  

    mov     x0, #1
    ldr     x1, =num2
    mov     x2, #len13
    mov     x8, #64         
    svc     #0

    mov     x0, #0
    ldr     x1, =numero2
    mov     x2, #10
    mov     x8, #63         
    svc     #0
    mov     x22, x0   

    mov     x0, #1
    ldr     x1, =resultadosuma
    mov     x2, #len14
    mov     x8, #64
    svc     #0

    ldr     x0, =numero1
    mov     x1, x21         
    bl      ascii_to_int
    mov     x19, x0         

    ldr     x0, =numero2
    mov     x1, x22         
    bl      ascii_to_int
    mov     x20, x0         

    add     x5, x19, x20   
    b       .L_imprimir_resultado


// opción2 de la resta

.L_opcion2: 
    mov     x0, #1
    ldr     x1, =num1
    mov     x2, #len12
    mov     x8, #64         
    svc     #0

    mov     x0, #0
    ldr     x1, =numero1
    mov     x2, #10
    mov     x8, #63         
    svc     #0
    mov     x21, x0  

    mov     x0, #1
    ldr     x1, =num2
    mov     x2, #len13
    mov     x8, #64         
    svc     #0

    mov     x0, #0
    ldr     x1, =numero2
    mov     x2, #10
    mov     x8, #63         
    svc     #0
    mov     x22, x0   

    mov     x0, #1
    ldr     x1, =resultadoresta
    mov     x2, #len16
    mov     x8, #64
    svc     #0

    ldr     x0, =numero1
    mov     x1, x21         
    bl      ascii_to_int
    mov     x19, x0         

    ldr     x0, =numero2
    mov     x1, x22         
    bl      ascii_to_int
    mov     x20, x0         

    sub     x5, x19, x20   
    b       .L_imprimir_resultado


// opcion3 para la multipliación
.L_opcion3: 
    mov     x0, #1          
    ldr     x1, =num1     
    mov     x2, #len12       
    mov     x8, #64         
    svc     #0

    mov     x0, #0          
    ldr     x1, =numero1     
    mov     x2, #10         
    mov     x8, #63         
    svc     #0
    mov     x20, x0         

    mov     x0, #1
    ldr     x1, =num2       
    mov     x2, #len13
    mov     x8, #64
    svc     #0

    mov     x0, #0
    ldr     x1, =numero2     
    mov     x2, #10
    mov     x8, #63
    svc     #0
    mov     x21, x0         

    mov     x0, #1
    ldr     x1, =resultadomulti       
    mov     x2, #len15
    mov     x8, #64
    svc     #0

    ldr     x0, =numero1 
    mov     x1, x20         
    bl      ascii_to_int
    mov     x19, x0         

    ldr     x0, =numero2
    mov     x1, x21         
    bl      ascii_to_int    
    mov     x20, x0         

    mul     x5, x19, x20    
    b       .L_imprimir_resultado 

// para la división con numeros enteteros
.L_opcion4: 
//escritura
    mov     x0, #1
    ldr     x1, =num1
    mov     x2, #len12
    mov     x8, #64         
    svc     #0

//lectura
    mov     x0, #0
    ldr     x1, =numero1
    mov     x2, #10
    mov     x8, #63         
    svc     #0
    mov     x21, x0  

    mov     x0, #1
    ldr     x1, =num2
    mov     x2, #len13
    mov     x8, #64         
    svc     #0

    mov     x0, #0
    ldr     x1, =numero2
    mov     x2, #10
    mov     x8, #63         
    svc     #0
    mov     x22, x0   

    ldr     x0, =numero1
    mov     x1, x21         
    bl      ascii_to_int
    mov     x19, x0         

    ldr     x0, =numero2
    mov     x1, x22         
    bl      ascii_to_int
    mov     x20, x0         

    // esto por si es entre cero
    cmp     x20, #0
    b.eq    .L_errordivision 

    mov     x0, #1
    ldr     x1, =resultadodiv
    mov     x2, #len17
    mov     x8, #64
    svc     #0

    udiv    x5, x19, x20   
    b       .L_imprimir_resultado

//opción 5 para la potencoa
.L_opcion5:

//opción 6 para el factorial
.L_opcion6: 


// paso a texto para poder imprimir en panttalla

.L_imprimir_resultado:
    ldr     x1, =res_txt 
    add     x1, x1, #15     
    mov     x2, #10         
    mov     x6, #0          

int_to_ascii_loop:
    udiv    x3, x5, x2      
    msub    x4, x3, x2, x5 
    add     x4, x4, #48     
    sub     x1, x1, #1
    strb    w4, [x1]        
    add     x6, x6, #1      
    mov     x5, x3          
    cbnz    x5, int_to_ascii_loop

    mov     x0, #1
    mov     x2, x6          
    mov     x8, #64
    svc     #0

    mov     x0, #1
    ldr     x1, =newline
    mov     x2, #1
    mov     x8, #64
    svc     #0

    b       .L_evaluar_continuar  

//para tirar algun mensaje de error
.L_error: 
    mov     x0, #1
    ldr     x1, =mensajerror
    mov     x2, #len11
    mov     x8, #64         
    svc     #0

    mov     x0, #1
    ldr     x1, =newline
    mov     x2, #1
    mov     x8, #64         
    svc     #0

.L_errordivision: 
    mov     x0, #1
    ldr     x1, =mensajerrordivision
    mov     x2, #len18
    mov     x8, #64         
    svc     #0

    mov     x0, #1
    ldr     x1, =newline
    mov     x2, #1
    mov     x8, #64         
    svc     #0
.L_evaluar_continuar:
    mov     x0, #1
    ldr     x1, =msg_desea_continuar
    mov     x2, #len_continuar
    mov     x8, #64         
    svc     #0

    mov     x0, #0
    ldr     x1, =resp_cont
    mov     x2, #10
    mov     x8, #63         
    svc     #0

    ldr     x1, =resp_cont
    ldrb    w0, [x1]

    cmp     w0, #'s'
    b.eq    .L_menu_loop    
    
    cmp     w0, #'S'
    b.eq    .L_menu_loop    

.L_end:
    mov     x0, #0 
    mov     x8, #93
    svc     #0 

//funciones para la suma
ascii_to_int:
    mov     x2, #0          
    mov     x3, #0          
    mov     x4, #10         

parse_loop:
    cmp     x3, x1
    bge     parse_end       
    ldrb    w5, [x0, x3]    
    
    cmp     w5, #10         
    b.eq    skip_char
    cmp     w5, #48
    blt     parse_end       
    cmp     w5, #57
    bgt     parse_end       

    sub     w5, w5, #48     
    mul     x2, x2, x4      
    add     x2, x2, x5      

skip_char:
    add     x3, x3, #1      
    b       parse_loop

parse_end:
    mov     x0, x2          
    ret
