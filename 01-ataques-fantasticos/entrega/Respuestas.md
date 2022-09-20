## Preguntas de enunciado

1. ¿Qué crítica le harías al protocolo de #estaHerido y #noEstaHerido? (en vez de tener solo el mensaje #estaHerido y hacer “#estaHerido not” para saber la negación)

La crítica que le podemos hacer es con respecto al modelo del comportamiento de la clase. Se manejan 2 estados distintos cuando se podría simplificar en uno solo, por ejemplo: un solo método ``estaHerido`` podria responder true o false. Asi mismo, estos métodos se repiten en otras clases y repercutiendo en su complejidad.

#
2. ¿Qué opinan de que para algunas funcionalidades tenemos 3 tests para el mismo comportamiento pero aplicando a cada uno de los combatientes (Arthas, Mankrik y Olgra)

Consideramos que estos tests son útiles para comprobar la totalidad del modelo, ya sea uno, dos o n combatientes. Además al aplicar polimorfismo, los mensajes de cada combatiente pueden responder de manera distinta.

#
3. ¿Cómo modelaron el resultado de haber desarrollado un combate? ¿qué opciones consideraron y por qué se quedaron con la que entregaron y por qué descartaron a las otras?

Nuestro planteo fue ciclar las n rondas realizando los ataques correspondientes de cada bando y comprobando en cada iteración si existe un ganador enviando un mensaje a un método interno de la clase **OrquestadorDeCombate**. Así mismo, en cada iteración revisa que se pueda seguir atacando, de no ser asi se corta el ciclo y retorna la n ronda actual. </br>
Nos quedamos con este modelo porque nos permitia ir validando los equipos a medida que atacabamos. También porque trabajamos con condiciones de corte y no agregamos complejidad al modelo con colaboradores internos y mas cantidad de métodos. En un momento se nos ocurrió realizar un método que orqueste todas las validaciones de combate, pero supimos que si lo desglozabamos ibamos a necesitar menos código y poder reutilizar métodos para ambos bandos por igual.