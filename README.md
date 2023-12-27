## **Challenge:** 
Crear una aplicación de lectura de noticias.
## **Introducción:**
La aplicación debe constar de 4 pantallas:

- Lista y buscador de noticias por título o contenido (Pantalla de Inicio)
- Detalles de la noticia seleccionada (Pantalla de Detalle)
- Lista de usuarios (Pantalla de Usuarios)
- Ubicación en el mapa del usuario (Pantalla de Mapa)

La app deberá ser una lista de noticias y una lista de usuarios. En la lista de usuarios debe mostrarse un botón que abra la pantalla de mapa, en donde con Google Maps debe mostrar la ubicación del usuario seleccionado. No hay restricciones en cuanto a los datos que se muestran tanto de las noticias como de los usuarios.

## **Requisitos técnicos:**
No es preciso crear servicios back-end para las APIs. Utilizar la API pública JSONPlaceholder (https://www.jsonplaceholder.org/).

## **Documentación de resolución:**

Cree una branch llamada ***develop*** y de allí fui sacando las *ramas features* para trabajar por separado cada sección. Luego de que terminé cada sección cree un PR hacía develop y una vez que tuve todos los cambios necesarios en develop, hice un PR hacia main. 

Para la creación de todas las vistas, opté por utilizar UIKit y diseñarlas de forma programática en lugar de utilizar Storyboard. Encuentro que este enfoque es más sencillo para organizar las vistas.

* En la sección de ***Listar y buscar noticias por título o contenido***, decidí implementar una UITableView. Esta tabla muestra celdas que reflejan de manera resumida el título y el contenido de cada noticia proveniente de la API pública de JSONPlaceholder. Para manipular la información de la API, creé un ViewModel que utiliza URLSession para obtener los datos y luego JSONDecoder para decodificar la información, utilizando un modelo de datos diseñado específicamente para la respuesta de esa API. Para la creación del modelo de datos, utilicé https://app.quicktype.io/, una herramienta que facilita la generación del modelo a partir de un JSON.
Para la función de búsqueda, implementé el elemento SearchBarController, el cual ya tiene una implementación que permite buscar en tiempo real dentro de la lista. También creé una vista detallada de manera programática para visualizar el título, la imagen, el contenido y la fecha de publicación. Seleccioné estos datos porque consideré que eran los más relevantes para una vista detallada, sin mostrar toda la información. Además, añadí un ScrollView a esta vista para que sea compatible con diferentes tamaños de pantalla.

* En la sección de ***Listar usuarios***, decidí utilizar también una UITableView para mostrar la lista de usuarios. En cada celda, solo se muestra el apellido y nombre de cada usuario. Si el usuario selecciona uno de ellos, se abrirá una URL que contiene la dirección del usuario y mostrará su posición en el mapa de Google Maps. El modelo de datos de Usuarios lo cree utilizando la misma aplicación que utilicé para Noticias. 

* Implementé un UITabBarController para gestionar ambas vistas, donde la vista principal es la Lista de Noticias y se puede cambiar fácilmente a la Lista de Usuarios.

* Para todas las vistas, creé un Snapshot Test para verificar la interfaz visual y también Unit Tests que consideré necesarios. Para poder realizar los snapshot test agregué en el podfile de la app el pod de SnapshoTest.

| Lista de Noticias | Buscador | 
| --------------- | --------- |
|![simulator_screenshot_16C50B64-E0E1-44ED-A0EC-9355BDD1EAE3](https://github.com/FlaminiaCastano/NewsletterApp/assets/88913777/f54dcbf0-37d5-44d7-a078-35ab812ab847)| ![simulator_screenshot_8D4D2351-1CEC-46BB-A74D-7A8B642E7539](https://github.com/FlaminiaCastano/NewsletterApp/assets/88913777/e8eb4a0b-464f-4680-a6c6-c865a8add663)|

| Detalle de Noticia | Detalle de Noticias |
| ------------------ | ------------------- |
|![simulator_screenshot_F05377A8-7C28-4019-80D5-58AA9DFA1A27](https://github.com/FlaminiaCastano/NewsletterApp/assets/88913777/c610f24e-8d9d-4ae1-a5d0-44a5bf639d43)|![simulator_screenshot_38759A7B-ABE2-4899-83BD-1F574A8041DC](https://github.com/FlaminiaCastano/NewsletterApp/assets/88913777/48154cc8-6b12-49f9-b8ae-eeadb99a8893)|

| Lista de Usuarios | Vista Google Maps |
| ----------------- | ----------------- |
|![simulator_screenshot_6D316AE4-96D0-4166-A4BA-B1E8304DF83D](https://github.com/FlaminiaCastano/NewsletterApp/assets/88913777/f861d769-75e3-490e-9934-26a0b3bc2464)|![simulator_screenshot_2E02E656-3F12-4F4A-BAFE-B8EE84D19F65](https://github.com/FlaminiaCastano/NewsletterApp/assets/88913777/f4b72105-0ef2-45bb-8ed4-efba40a6edd5)|
