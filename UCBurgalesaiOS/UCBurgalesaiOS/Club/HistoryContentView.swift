//
//  HistoryView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//



import SwiftUI

struct HistoryView: View {
    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 30) {
                    VStack(alignment: .leading, spacing: 10) {
                        sectionHeader("Historia del Club")
                            .bold()

                        Text("Este rincón está reservado para recordar parte de la historia de la UNIÓN CICLOTURISTA BURGALESA.")
                            .bold()
                            .padding(.bottom, 10)
                            

                        Image("historyClubPhoto")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .padding(.bottom, 10)

                        Text("Los buenos y malos momentos de esta sociedad han sido fruto de un duro trabajo, personas que desinteresadamente ha trabajado por llevar a cabo una ferviente actividad, y estas páginas serán tributo de ese trabajo. Iremos recopilando folletos, fotografías, breves resúmenes de actividades, recortes de prensa, las lista de los campeones de la sociedad, presidentes, etc.., el periodo de tiempo que alcanza va desde nuestra fundación hasta hoy en día.")
                        Text("Un poco de historia La UNIÓN CICLOTURISTA BURGALESA, fue fundada el 30 de Diciembre de 1.971 por un grupo de aficionados al ciclismo, durante las cuales su principal razón de ser ha sido fomentar el compañerismo y la práctica al ciclismo.")
                             
                        Text(" Desde la fundación de esta sociedad continuamente se han ido preparando distintas pruebas, pruebas que le ido haciendo su lugar en el mundo de la bicicleta. Utilizando las cuotas de los socios, como pequeñas aportaciones de entidades y comercios para sufragar el coste de las distintas pruebas. Ya en su primera temporada realizó su primer reto, la Marathón Española prueba de mayor longitud que ha realizado esta sociedad con 384 kilómetros, en un sólo día comenzado la prueba a la 0:00 horas, está prueba se estubo organizando hasta el año 2000, cada 2 años. En 1.982 se iniciaron las primeras marchas Intersociales, que pasaron por Burgos, Castrojeriz, Briviesca, Pradoluengo, Covarrubias, Poza de la Sal, Belorado. Lerma, etc. En 1997 organizamos la primera Marcha Lagunas de Neila, con la esperanza de hacerla una de las pruebas más relevantes de España. Las carreras más importantes han tenido lugar Juveniles (Pradoluengo, Castrojeriz, Burgos), Aficionados (Frías, Burgos), Veteranos (Burgos, Espinosa,) etc.")
                        Text("De los VEINTIUNO primeros socios fundadores hemos llegado en algún momento a superar los doscientos cincuenta socios, siendo una de las sociedades más nutridas de la comunidad, lo cual es una prueba de labor realizada en estos años, en el fomento del cicloturismo, como del ciclismo en general. Destacando que la edad de los socios abarca las diferentes grupos como socios no activos de 1917, siendo el socio en activo más veteranos de 1.921 al más joven nació 1996. Tan variado es la edad de los socios como las cualidades de los mismos, habiendo socios que han llegado a lo más alto del ciclismo, y otros rozando tal honor, como los que se contentan con superarse así mismo semanalmente con estos pequeños esfuerzos.")
                        Text("A largo de estos años hemos sido testigos tanto de la evolución de las bicicletas esos grandes «cacharros» de las primeras temporadas a la ligeras bicicletas modernas, incluso de la mejora de las carreteras que de caminos rurales ha ido tomando cuerpo a carretera mejor asfaltadas como la gran novedad que supuso el asfaltado del Altotero de Poza tomando categoría de gran cumbre, formando lo que se puede llamar una de las redes provinciales más extensa de España, que con la buena situación de Burgos capital en este nudo nos permite una gran variación a la hora de elegir las rutas que configuran nuestro calendario, Con el único objetivo de dar a conocer nuestra provincias tanto a nosotros mismo lo burgaleses como a otros cicloturistas de otras provincias. A largo de estos veintiocho años hemos recorrido casi la totalidad de carreteras de nuestra provincia del norte, al sur y del este al oeste, incluso recorriendo parte de otras limítrofes como Santander, La Rioja, Palencia, Incluso llegando hasta Santiago de Compostela en 1.992, y 2000 desde Burgos y Roncesvalle, sin contar las participaciones de nuestros socios en pruebas cicloturistas de otras provincias españolas incluso internacionales, Francia, Italia.")
                        Text("'La suma de todos los kilómetros que hemos recorrido estos años superará sin duda superara varias veces el millón de kilómetros, contando únicamente los kilómetros realizados de domingo a domingo de todos los socios.'")
                            .font(.headline)
                    }
                    .sectionStyle()
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding()
            }
        }
    }

    func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .padding(.vertical)
    }
}



struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}


