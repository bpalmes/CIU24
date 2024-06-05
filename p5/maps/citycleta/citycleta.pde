PGraphics lienzo;
PImage img;

float minlat, minlon, maxlat, maxlon;

float[] lats, lons;
String[] nombres;
int[] devoluciones; // Nuevo arreglo para almacenar el número de devoluciones
int nest = 0;
int r = 5;

float zoom;
int x, y;

Table Estaciones;
Table Devoluciones; // Nueva tabla para cargar devoluciones

void setup() {
  size(800, 800, P3D);

  // Cargamos información de estaciones de préstamo
  Estaciones = loadTable("Geolocalización estaciones sitycleta.csv", "header");
  // Estaciones.getRowCount() contiene el número de entradas
  // Creamos estructura para almacenar lo que nos interesa
  lats = new float[Estaciones.getRowCount()];
  lons = new float[Estaciones.getRowCount()];
  nombres = new String[Estaciones.getRowCount()];
  devoluciones = new int[Estaciones.getRowCount()]; // Inicializamos el nuevo arreglo
  
  // Almacenamos datos en nuestra estructura
  nest = 0;
  for (TableRow est : Estaciones.rows()) {
    nombres[nest] = est.getString("nombre");
    lats[nest] = float(est.getString("latitud"));
    lons[nest] = float(est.getString("altitud"));

    println(nombres[nest], lats[nest], lons[nest]);
    nest++;
  }

  // Cargamos datos de devoluciones
  Devoluciones = loadTable("devoluciones_marzo_2024.csv", "header");
  for (TableRow row : Devoluciones.rows()) {
    String returnPlace = row.getString("Return place");
    // Contamos las devoluciones por estación
    for (int i = 0; i < nest; i++) {
      if (nombres[i].equals(returnPlace)) {
        devoluciones[i]++;
        break;
      }
    }
  }

  // Imagen del Mapa
  img = loadImage("map.png");
  // Creamos lienzo para el mapa
  lienzo = createGraphics(img.width, img.height);
  lienzo.beginDraw();
  lienzo.background(100);
  lienzo.endDraw();
  
  // Latitud y longitud de los extremos del mapa de la imagen
  minlon = -15.4447;
  maxlon = -15.4282;
  minlat = 28.1330;
  maxlat = 28.1442;

  // Inicializa desplazamiento y zoom
  x = 0;
  y = 0;
  zoom = 1;

  // Compone imagen con estaciones sobre el lienzo
  dibujaMapayEstaciones();  
}

void draw() {
  background(220);
  // Desplazamiento con botón izquierdo ratón
  if (mousePressed && mouseButton == LEFT) {
    x += (mouseX - pmouseX) / zoom;
    y += (mouseY - pmouseY) / zoom;
  }

  // Coloca origen en el centro
  translate(width / 2, height / 2, 0);
  // Escala según el zoom
  scale(zoom);
  // Centro de la imagen en el origen
  translate(-img.width / 2 + x, -img.height / 2 + y);

  image(lienzo, 0, 0);
}

// Rueda del ratón para modificar el zoom
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom += e / 10;
  if (zoom < 1)
    zoom = 1;
}

void dibujaMapayEstaciones() {
  // Dibuja sobre el lienzo
  lienzo.beginDraw();
  // Imagen de fondo
  lienzo.image(img, 0, 0, img.width, img.height);
  // Círculo y etiqueta de cada estación según latitud y longitud
  for (int i = 0; i < nest; i++) {
    float mlon = map(lons[i], minlon, maxlon, 0, img.width);
    // latitud invertida con respecto al eje y de la ventana
    float mlat = map(lats[i], maxlat, minlat, 0, img.height);

    lienzo.fill(0, 255, 0);
    lienzo.ellipse(mlon, mlat, r, r);
    lienzo.fill(0, 0, 0);
    lienzo.text(nombres[i], mlon + r * 2, mlat);
    // Dibuja la baliza con el número de devoluciones
    lienzo.fill(255, 0, 0);
    lienzo.text(devoluciones[i], mlon + r * 2, mlat + 15); // Ajusta la posición de la baliza según sea necesario
  }   
  lienzo.endDraw();
}
