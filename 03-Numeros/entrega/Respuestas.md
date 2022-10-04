# Preguntas de enunciado

### 1. Aporte de los mensajes de DD
    En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

El double dispatch se compone de 2 llamados. El primero consta del llamado al metodo de la operacion en si (+ - * / fibonacci) el cual nos brinda informacion acerca del primer objeto (el primer numero), donde dentro se realiza el segundo llamado el cual delega la responsabilidad al segundo objeto sin importar su tipo (Entero o Fraccion) y se pasa a si mismo como argumento.


### 2. Lógica de instanciado
    Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

Para nosotros la logica para instanciar un objeto se debe hacer dentro de un metodo de la misma clase para facilitar la creacion de su instancia desde diferentes lugares.

### 3. Nombres de las categorías de métodos
    Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

Nuestro criterio se basa en la funcionalidad del metodo, dependiendo de que hace lo categorizamos (la suma va dentro de la categoria arithmetic operations).

### 4. Subclass Responsibility
    Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

Lo que realizamos al poner subclassResponsibility en el metodo de la superclase delegamos la implementacion a cada subclase para que pueda responder de distintas formas al mismo metodo. Esto corresponde a una clase abstracta (superclase), que es aquella que no tiene sentido instanciar porque es demasiado genérica y no tiene una implementación concreta para algunos mensajes que debería entender porque está definido en sus subclases.

### 5. No rompas
    ¿Por qué está mal/qué problemas trae romper encapsulamiento?

Cuando rompemos encapsulamiento nos trae como consecuencia un alto acoplamiento entre objetos y rompe con el paradigma de la POO. Para corregir esto debemos hacer que los objetos no conozcan el funcionamiento interno de sus clases hijas mediante la delegacion de comportamiento a traves de mensajes.