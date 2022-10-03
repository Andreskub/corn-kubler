# Preguntas de enunciado

### 1. Aporte de los mensajes de DD
    En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

En este caso, el double dispatch se compone de 2 llamados. El primero consta del llamado al metodo de la operacion en si (+ - * / fibonacci), donde dentro se realiza el segundo llamado el cual delega la responsabilidad al objeto sin importar su tipo (Entero o Fraccion) y se pasa a si mismo como argumento.

### 2. Lógica de instanciado
    Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

Abc

### 3. Nombres de las categorías de métodos
    Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

Abc

### 4. Subclass Responsibility
    Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

Lo que realizamos al poner subclassResponsibility en el metodo de la superclase delegamos la implementacion a cada subclase para que pueda responder de distintas formas al mismo metodo. Esto corresponde a una clase abstracta (superclase), que es aquella que no tiene sentido instanciar porque es demasiado genérica y no tiene una implementación concreta para algunos mensajes que debería entender porque está definido en sus subclases.

### 5. No rompas
    ¿Por qué está mal/qué problemas trae romper encapsulamiento?

acomplamiento y cohesion