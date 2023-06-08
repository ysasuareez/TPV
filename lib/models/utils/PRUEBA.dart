import 'package:flutter/material.dart';
import 'package:restaurante/services/firebase_service.dart';

import '../firebase/category.dart';
import '../firebase/item.dart';
import '../firebase/subcategory.dart';

class PRUEBA extends StatefulWidget {
  const PRUEBA({super.key});

  @override
  PRUEBAState createState() => PRUEBAState();
}

class PRUEBAState extends State<PRUEBA> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Category bebidas = Category(
      id: 'a_bebidas',
      name: 'BEBIDAS',
      subcategories: [
        Subcategory(
          id: 'a_refrescos',
          name: 'REFRESCOS',
          items: [
            Item(
              id: 'a_coca_cola',
              name: 'COCA-COLA',
              price: 2.5,
            ),
            Item(
              id: 'b_coca_cola_zero',
              name: 'C ZERO',
              price: 2.5,
            ),
            Item(
              id: 'c_coca_cola_light',
              name: 'C LIGHT',
              price: 2.5,
            ),
            Item(
              id: 'd_sprite',
              name: 'SPRITE',
              price: 2.5,
            ),
            Item(
              id: 'e_fanta_naranja',
              name: 'F NARANJA',
              price: 2.5,
            ),
            Item(
              id: 'f_fanta_limón',
              name: 'F LIMÓN',
              price: 2.5,
            ),
            Item(
              id: 'g_aquarius',
              name: 'AQUARIUS',
              price: 2.5,
            ),
            Item(
              id: 'h_nestea',
              name: 'NESTEA',
              price: 2.5,
            ),
            Item(
              id: 'i_nestea_maracuya',
              name: 'N MARACUYÁ',
              price: 2.5,
            ),
            Item(
              id: 'j_tonica_clasica',
              name: 'TONICA CLÁSICA',
              price: 2.5,
            ),
            Item(
              id: 'k_tonica_blue',
              name: 'TONICA BLUE',
              price: 2.5,
            ),
            Item(
              id: 'l_tonica_frutos_rojos',
              name: 'TONICA ROJOS',
              price: 2.5,
            ),
            Item(
              id: 'm_tonica_mediterranea',
              name: 'TONICA MEDITERRÁNEA',
              price: 2.5,
            ),
            Item(
              id: 'n_7up',
              name: '7UP',
              price: 2.5,
            ),
            Item(
              id: 'o_agua',
              name: 'AGUA',
              price: 1.5,
            ),
            Item(
              id: 'o_agua_1L',
              name: 'AGUA 1L',
              price: 2.5,
            ),
            Item(
              id: 'i_poco_hielo',
              name: 'POCO HIELO',
              price: 0.0,
            ),
            Item(
              id: 'i_no_limon',
              name: 'NO LIMON',
              price: 0.0,
            ),
            Item(
              id: 'i_no_naranda',
              name: 'NO NARANJA',
              price: 0.0,
            ),
          ],
        ),
        Subcategory(
          id: 'b_zumos_naturales',
          name: 'ZUMOS',
          items: [
            Item(
              id: 'a_afrodisiaco',
              name: 'AFRODISÍACO',
              price: 10.0,
            ),
            Item(
              id: 'b_explosivo',
              name: 'EXPLOSIVO',
              price: 10.0,
            ),
            Item(
              id: 'c_vitaminico',
              name: 'VITAMÍNICO',
              price: 10.0,
            ),
            Item(
              id: 'd_alucinante',
              name: 'ALUCINANTE',
              price: 10.0,
            ),
            Item(
              id: 'e_granizado',
              name: 'GRANIZADO',
              price: 10.0,
            ),
            Item(
              id: 'f_guey',
              name: 'GÜEY',
              price: 10.0,
            ),
            Item(
              id: 'g_naranja_natural',
              name: 'NARANJA NATURAL',
              price: 6.0,
            ),
            Item(
              id: 'h_mendoza',
              name: 'MENDOZA',
              price: 10.0,
            ),
            Item(
              id: 'i_energetico',
              name: 'ENERGÉTICO',
              price: 10.0,
            ),
            Item(
              id: 'j_exotico',
              name: 'EXÓTICO',
              price: 10.0,
            ),
            Item(
              id: 'k_electrico',
              name: 'ELÉCTRICO',
              price: 10.0,
            ),
            Item(
              id: 'l_apasionante',
              name: 'APASIONANTE',
              price: 10.0,
            ),
            Item(
              id: 'm_bronceado',
              name: 'BRONCEADO',
              price: 10.0,
            ),
            Item(
              id: 'n_a_tu_gusto',
              name: 'A TU GUSTO',
              price: 10.0,
            ),
          ],
        ),
        Subcategory(
          id: 'c_batidos',
          name: 'BATIDOS',
          items: [
            Item(
              id: 'a_danup',
              name: 'DANUP',
              price: 10.0,
            ),
            Item(
              id: 'b_argentiniano',
              name: 'ARGENTINIANO',
              price: 10.0,
            ),
            Item(
              id: 'c_impresionante',
              name: 'IMPRESIONANTE',
              price: 10.0,
            ),
            Item(
              id: 'd_vibrante',
              name: 'VIBRANTE',
              price: 10.0,
            ),
            Item(
              id: 'e_madeiros',
              name: 'MADEIROS',
              price: 10.0,
            ),
            Item(
              id: 'f_oreo',
              name: 'OREO',
              price: 10.0,
            ),
            Item(
              id: 'g_batido_puleva_chocolate',
              name: 'PULEVA CHOCOLATE',
              price: 2.5,
            ),
            Item(
              id: 'h_batido_puleva_fresa',
              name: 'PULEVA FRESA',
              price: 2.5,
            ),
            Item(
              id: 'c_batido_puleva_vainilla',
              name: 'PULEVA VAINILLA',
              price: 2.5,
            ),
            Item(
              id: 'g_platano',
              name: 'PLÁTANO',
              price: 7.0,
            ),
            Item(
              id: 'j_mango',
              name: 'MANGO',
              price: 3.0,
            ),
            Item(
              id: 'j_fresa',
              name: 'FRESA',
              price: 3.0,
            ),
          ],
        ),
        Subcategory(id: 'd_cocktails', name: 'CÓCTELES', items: [
          Item(id: 'a_mojito', name: 'MOJITO', price: 9.0),
          Item(id: 'b_p_colada', name: 'P COLADA', price: 10.0),
          Item(id: 'c_coco_beach', name: 'COCO BEACH', price: 10.0),
          Item(id: 'd_mai_tai', name: 'MAI TAI', price: 10.0),
          Item(id: 'e_sex_on_b', name: 'SEX ON B', price: 10.0),
          Item(id: 'f_espresso_m', name: 'ESPRESSO M', price: 10.0),
          Item(id: 'g_long_island', name: 'LONG ISLAND', price: 10.0),
          Item(id: 'h_tequila_sunrise', name: 'TEQUILA SUNRISE', price: 10.0),
          Item(id: 'i_daiquiri', name: 'DAIQUIRI', price: 10.0),
          Item(id: 'j_mojito_granizado', name: 'MOJITO GRANIZADO', price: 10.0),
          Item(id: 'k_bloody_mary', name: 'BLOODY MARY', price: 10.0),
          Item(id: 'l_black_russian', name: 'BLACK RUSSIAN', price: 10.0),
          Item(id: 'm_margarita', name: 'MARGARITA', price: 10.0),
        ]),
        Subcategory(id: 'e_cervezas', name: 'CERVEZAS', items: [
          Item(id: 'a_cana', name: 'CAÑA', price: 2.50),
          Item(id: 'b_tintov', name: 'TINTOV', price: 3.0),
          Item(id: 'c_coronita', name: 'CORONITA 1/3', price: 4.0),
          Item(id: 'd_pinta', name: 'PINTA', price: 4.0),
          Item(id: 'f_sanmiguel_cero', name: 'SM 0 1/3', price: 4.0),
          Item(
              id: 'g_sanmiguel_especial', name: 'SM ESPECIAL 1/3', price: 3.50),
          Item(id: 'h_sanmiguel_tercio', name: 'SM 1/3', price: 3.50),
          Item(id: 'k_alhambra_verde', name: 'ALHAMBRA VERDE', price: 4.0),
          Item(id: 'l_cruzcampo', name: 'CRUZCAMPO', price: 3.0),
          Item(id: 'n_estrella_damm', name: 'ESTRELLA DAMM', price: 3.50),
          Item(id: 'q_heineken', name: 'HEINEKEN', price: 4.0),
          Item(id: 'u_becks', name: 'BECKS', price: 4.0),
          Item(id: 'x_con_vaso', name: 'CON VASO', price: 4.0),
        ]),
        Subcategory(id: 'f_gin', name: 'GIN', items: [
          Item(id: 'a_beefeater', name: 'BEEFEATER', price: 8.0),
          Item(id: 'b_seagrams', name: 'SEAGRAMS', price: 8.0),
          Item(id: 'c_beefeater_liht', name: 'BEEFEATER LIGHT', price: 8.0),
          Item(id: 'd_beefeater_pink', name: 'BEEFEATER PINK', price: 8.0),
          Item(id: 'e_master', name: 'MASTER', price: 8.0),
          Item(id: 'f_master_pink', name: 'MASTER PINK', price: 8.0),
          Item(id: 'g_nordés', name: 'NORDÉS', price: 9.0),
          Item(id: 'h_hendrick´s', name: 'HENDRICK´S', price: 11.0),
          Item(id: 'i_martin_millers', name: 'MARTIN MILLERS', price: 11.0),
          Item(id: 'l_coca_cola', name: 'COCA-COLA', price: 0),
          Item(id: 'm_coca_cola_zero', name: 'C ZERO', price: 0),
          Item(id: 'n_coca_cola_light', name: 'C LIGHT', price: 0),
          Item(id: 'o_sprite', name: 'SPRITE', price: 0),
          Item(id: 'p_fanta_naranja', name: 'F NARANJA', price: 0),
          Item(id: 'q_fanta_limón', name: 'F LIMÓN', price: 0),
          Item(id: 'r_aquarius', name: 'AQUARIUS', price: 0),
          Item(id: 's_nestea', name: 'NESTEA', price: 0),
          Item(id: 't_nestea_maracuya', name: 'N MARACUYÁ', price: 0),
          Item(id: 'u_tonica_clasica', name: 'TONICA CLÁSICA', price: 0),
          Item(id: 'v_tonica_blue', name: 'TONICA BLUE', price: 0),
          Item(id: 'w_tonica_frutos_rojos', name: 'TONICA ROJOS', price: 0),
          Item(
              id: 'x_tonica_mediterranea',
              name: 'TONICA MEDITERRÁNEA',
              price: 0),
          Item(id: 'y_7up', name: '7UP', price: 0),
          Item(id: 'z_agua', name: 'AGUA', price: 0),
          Item(id: 'z_agua_1L', name: 'AGUA 1L', price: 0),
          Item(id: 'zz_poco_hielo', name: 'POCO HIELO', price: 0.0),
          Item(id: 'zz_no_limon', name: 'NO LIMON', price: 0.0),
          Item(id: 'zz_no_naranda', name: 'NO NARANJA', price: 0.0),
          Item(id: 'zz_corto', name: 'CORTO', price: 0.0),
        ]),
        Subcategory(id: 'g_ron', name: 'RON', items: [
          Item(id: 'a_havana_7', name: 'HAVANA 7', price: 8.0),
          Item(id: 'b_barceló', name: 'BARCELÓ', price: 8.0),
          Item(id: 'c_negrita_añejo', name: 'NEGRITA AÑEJO', price: 7.0),
          Item(id: 'd_malibú', name: 'MALIBÚ', price: 8.0),
          Item(id: 'e_legendario', name: 'LEGENDARIO', price: 8.0),
          Item(id: 'f_cacique', name: 'CACIQUE', price: 8.0),
          Item(id: 'g_cacique_500', name: 'CACIQUE 500', price: 9.0),
          Item(id: 'h_matusalén', name: 'MATUSALÉN', price: 12.0),
          Item(
              id: 'i_zacapa_centenario',
              name: 'ZACAPA CENTENARIO',
              price: 12.0),
          Item(id: 'l_coca_cola', name: 'COCA-COLA', price: 0),
          Item(id: 'm_coca_cola_zero', name: 'C ZERO', price: 0),
          Item(id: 'n_coca_cola_light', name: 'C LIGHT', price: 0),
          Item(id: 'o_sprite', name: 'SPRITE', price: 0),
          Item(id: 'p_fanta_naranja', name: 'F NARANJA', price: 0),
          Item(id: 'q_fanta_limón', name: 'F LIMÓN', price: 0),
          Item(id: 'r_aquarius', name: 'AQUARIUS', price: 0),
          Item(id: 's_nestea', name: 'NESTEA', price: 0),
          Item(id: 't_nestea_maracuya', name: 'N MARACUYÁ', price: 0),
          Item(id: 'u_tonica_clasica', name: 'TONICA CLÁSICA', price: 0),
          Item(id: 'v_tonica_blue', name: 'TONICA BLUE', price: 0),
          Item(id: 'w_tonica_frutos_rojos', name: 'TONICA ROJOS', price: 0),
          Item(
              id: 'x_tonica_mediterranea',
              name: 'TONICA MEDITERRÁNEA',
              price: 0),
          Item(id: 'y_7up', name: '7UP', price: 0),
          Item(id: 'z_agua', name: 'AGUA', price: 0),
          Item(id: 'z_agua_1L', name: 'AGUA 1L', price: 0),
          Item(id: 'zz_poco_hielo', name: 'POCO HIELO', price: 0.0),
          Item(id: 'zz_no_limon', name: 'NO LIMON', price: 0.0),
          Item(id: 'zz_no_naranda', name: 'NO NARANJA', price: 0.0),
          Item(id: 'zz_corto', name: 'CORTO', price: 0.0),
        ]),
        Subcategory(id: 'h_whisky', name: 'WHISKY', items: [
          Item(id: 'a_ballantines', name: 'BALLANTINES', price: 8.0),
          Item(id: 'b_jameson', name: 'JAMESON', price: 8.0),
          Item(id: 'c_cutty_sark', name: 'CUTTY SARK', price: 11.0),
          Item(id: 'd_dyc8', name: 'DYC8', price: 8.0),
          Item(id: 'e_jb', name: 'JB', price: 8.0),
          Item(id: 'f_jack_d', name: 'JACK D', price: 9.0),
          Item(id: 'g_southern', name: 'SOUTHERN', price: 9.0),
          Item(id: 'h_john_w_white', name: 'JOHN W WHITE', price: 8.0),
          Item(id: 'i_john_w_red', name: 'JOHN W RED', price: 8.0),
          Item(id: 'j_john_w_black', name: 'JOHN W BLACK', price: 11.0),
          Item(id: 'k_macallan_12', name: 'MACALLAN 12', price: 11.0),
          Item(id: 'l_coca_cola', name: 'COCA-COLA', price: 0),
          Item(id: 'm_coca_cola_zero', name: 'C ZERO', price: 0),
          Item(id: 'n_coca_cola_light', name: 'C LIGHT', price: 0),
          Item(id: 'o_sprite', name: 'SPRITE', price: 0),
          Item(id: 'p_fanta_naranja', name: 'F NARANJA', price: 0),
          Item(id: 'q_fanta_limón', name: 'F LIMÓN', price: 0),
          Item(id: 'r_aquarius', name: 'AQUARIUS', price: 0),
          Item(id: 's_nestea', name: 'NESTEA', price: 0),
          Item(id: 't_nestea_maracuya', name: 'N MARACUYÁ', price: 0),
          Item(id: 'u_tonica_clasica', name: 'TONICA CLÁSICA', price: 0),
          Item(id: 'v_tonica_blue', name: 'TONICA BLUE', price: 0),
          Item(id: 'w_tonica_frutos_rojos', name: 'TONICA ROJOS', price: 0),
          Item(
              id: 'x_tonica_mediterranea',
              name: 'TONICA MEDITERRÁNEA',
              price: 0),
          Item(id: 'y_7up', name: '7UP', price: 0),
          Item(id: 'z_agua', name: 'AGUA', price: 0),
          Item(id: 'z_agua_1L', name: 'AGUA 1L', price: 0),
          Item(id: 'zz_poco_hielo', name: 'POCO HIELO', price: 0.0),
          Item(id: 'zz_no_limon', name: 'NO LIMON', price: 0.0),
          Item(id: 'zz_no_naranda', name: 'NO NARANJA', price: 0.0),
          Item(id: 'zz_corto', name: 'CORTO', price: 0.0),
        ]),
        Subcategory(id: 'i_vodka', name: 'VODKA', items: [
          Item(id: 'a_absolut', name: 'ABSOLUT', price: 8.0),
          Item(id: 'b_smirnoff', name: 'SMIRNOFF', price: 8.0),
          Item(id: 'c_ciroc', name: 'CIROC', price: 12.0),
          Item(id: 'd_ciroc_apple', name: 'CIROC APPLE', price: 9.0),
          Item(id: 'e_belvedere', name: 'BELVEDERE', price: 12.0),
          Item(id: 'l_coca_cola', name: 'COCA-COLA', price: 0),
          Item(id: 'm_coca_cola_zero', name: 'C ZERO', price: 0),
          Item(id: 'n_coca_cola_light', name: 'C LIGHT', price: 0),
          Item(id: 'o_sprite', name: 'SPRITE', price: 0),
          Item(id: 'p_fanta_naranja', name: 'F NARANJA', price: 0),
          Item(id: 'q_fanta_limón', name: 'F LIMÓN', price: 0),
          Item(id: 'r_aquarius', name: 'AQUARIUS', price: 0),
          Item(id: 's_nestea', name: 'NESTEA', price: 0),
          Item(id: 't_nestea_maracuya', name: 'N MARACUYÁ', price: 0),
          Item(id: 'u_tonica_clasica', name: 'TONICA CLÁSICA', price: 0),
          Item(id: 'v_tonica_blue', name: 'TONICA BLUE', price: 0),
          Item(id: 'w_tonica_frutos_rojos', name: 'TONICA ROJOS', price: 0),
          Item(
              id: 'x_tonica_mediterranea',
              name: 'TONICA MEDITERRÁNEA',
              price: 0),
          Item(id: 'y_7up', name: '7UP', price: 0),
          Item(id: 'z_agua', name: 'AGUA', price: 0),
          Item(id: 'z_agua_1L', name: 'AGUA 1L', price: 0),
          Item(id: 'zz_poco_hielo', name: 'POCO HIELO', price: 0.0),
          Item(id: 'zz_no_limon', name: 'NO LIMON', price: 0.0),
          Item(id: 'zz_no_naranda', name: 'NO NARANJA', price: 0.0),
          Item(id: 'zz_corto', name: 'CORTO', price: 0.0),
        ]),
        Subcategory(id: 'j_licores', name: 'LICORES', items: [
          Item(id: 'a_baileys', name: 'BAILEYS', price: 6.0),
          Item(id: 'b_orujo', name: 'ORUJO', price: 6.0),
          Item(id: 'c_malavita', name: 'MALAVITA', price: 6.0),
          Item(id: 'd_jäger', name: 'JÄGER', price: 6.0),
          Item(id: 'e_l43', name: 'L43', price: 6.0),
          Item(id: 'f_hierbas', name: 'HIERBAS', price: 6.0),
          Item(id: 'g_martini_blanco', name: 'MARTINI BLANCO', price: 6.0),
          Item(id: 'h_martini_rosso', name: 'MARTINI ROSSO', price: 6.0),
          Item(id: 'i_pacharán', name: 'PACHARÁN', price: 6.0),
          Item(id: 'j_ponche', name: 'PONCHE', price: 6.0),
          Item(id: 'k_tía_maría', name: 'TÍA MARÍA', price: 6.0),
          Item(
              id: 'l_tequila_don_julio',
              name: 'TEQUILA DON JULIO',
              price: 15.0),
        ]),
      ],
    );

    final Category comidas = Category(
      id: 'b_comidas',
      name: 'COMIDAS',
      subcategories: [
        Subcategory(id: 'a_entrantes', name: 'ENTRANTES', items: [
          Item(id: 'a_salada_qtempl', name: 'SALADA QTEMPL', price: 10.0),
          Item(id: 'b_salada_césar', name: 'SALADA CÉSAR', price: 11.0),
          Item(id: 'c_ceviche', name: 'CEVICHE', price: 14.0),
          Item(id: 'd_tartar_atún', name: 'TARTAR ATÚN', price: 18.0),
          Item(id: 'e_tartar_almón', name: 'TARTAR ALMÓN', price: 16.0),
          Item(id: 'f_tartar_salch', name: 'TARTAR SALCH', price: 12.0),
          Item(id: 'g_carpaccio', name: 'CARPACCIO', price: 15.0),
          Item(id: 'h_pulpitos', name: 'PULPITOS', price: 13.0),
          Item(id: 'i_alitas_pollo', name: 'ALITAS POLLO', price: 14.0),
          Item(id: 'j_tosta_gambas', name: 'TOSTA GAMBAS', price: 12.0),
          Item(id: 'k_tosta_salmon', name: 'TOSTA SALMÓN', price: 14.0),
          Item(id: 'l_molletito', name: 'MOLLETITO', price: 9.0),
          Item(id: 'n_patatas_bravas', name: 'PATATASBRAVAS', price: 8.0),
          Item(id: 'o_ensalada_caprese', name: 'ENSALADA CAPRESE', price: 10.0),
          Item(id: 'p_empanada', name: 'EMPANADA', price: 7.0),
          Item(id: 'q_buñuelos_bacalao', name: 'BUÑUELOS BACALAO', price: 9.0),
          Item(id: 'r_croquetas_jamon', name: 'CROQUETAS JAMON', price: 8.0),
          Item(id: 's_pilpil', name: 'PIL-PIL', price: 8.0)
        ]),
        Subcategory(id: 'c_pescados', name: 'PESCADOS', items: [
          Item(id: 'a_pulpo', name: 'PULPO', price: 25.0),
          Item(id: 'b_salmón', name: 'SALMÓN', price: 18.0),
          Item(id: 'c_sardinas', name: 'SARDINAS', price: 8.0),
          Item(id: 'd_calamar', name: 'CALAMAR', price: 44.0),
          Item(id: 'e_trucha', name: 'TRUCHA', price: 20.0),
          Item(id: 'f_bacalao', name: 'BACALAO', price: 22.0),
          Item(id: 'g_lubina', name: 'LUBINA', price: 28.0),
          Item(id: 'h_merluza', name: 'MERLUZA', price: 19.0),
          Item(id: 'i_rodaballo', name: 'RODABALLO', price: 32.0),
          Item(id: 'j_rape', name: 'RAPE', price: 26.0),
          Item(id: 'k_anguila', name: 'ANGUILA', price: 35.0),
          Item(id: 'l_bogavante', name: 'BOGAVANTE', price: 50.0),
          Item(id: 'm_gambas', name: 'GAMBAS', price: 30.0),
          Item(id: 'n_navajas', name: 'NAVAJAS', price: 16.0),
          Item(id: 'o_patata_asada', name: 'PATATA ASADA', price: 0.0),
          Item(id: 'p_verdura', name: 'VERDURA', price: 0.0),
          Item(id: 'q_patatas_fritas', name: 'PATATAS FRITAS', price: 0.0),
          Item(id: 'r_patatas_gajo', name: 'PATATAS GAJO', price: 0.0)
        ]),
        Subcategory(id: 'c_carnes', name: 'CARNES', items: [
          Item(id: 'a_bife_chorizo', name: 'BIFE CHORIZO', price: 18.0),
          Item(id: 'b_asado_tira', name: 'ASADO TIRA', price: 15.0),
          Item(id: 'c_lomo_vaca', name: 'LOMO VACA', price: 20.0),
          Item(id: 'd_filet_mignon', name: 'FILET MIGNON', price: 22.0),
          Item(
              id: 'e_costillas_cordero',
              name: 'COSTILLAS CORDERO',
              price: 16.0),
          Item(id: 'f_solomillo_cerdo', name: 'SOLOMILLO CERDO', price: 22.0),
          Item(id: 'g_chuletón', name: 'CHULETÓN TERNERA', price: 25.0),
          Item(id: 'h_medallones', name: 'MEDALLONES TERNERA', price: 18.0),
          Item(id: 'i_entrecot', name: 'ENTRECOT BUEY', price: 26.0),
          Item(id: 'k_patata_asada', name: 'PATATA ASADA', price: 0.0),
          Item(id: 'l_verdura', name: 'VERDURA', price: 0.0),
          Item(id: 'm_patatas_fritas', name: 'PATATAS FRITAS', price: 0.0),
          Item(id: 'n_patatas_gajo', name: 'PATATAS GAJO', price: 0.0),
          Item(id: 'o_poco_hecho', name: 'POCO HECHO', price: 0.0),
          Item(id: 'p_al_punto', name: 'AL PUNTO', price: 0.0),
          Item(id: 'q_hecho', name: 'HECHO', price: 0.0),
          Item(id: 'r_muy_hecho', name: 'MUY HECHO', price: 0.0)
        ]),
        Subcategory(id: 'e_postres', name: 'POSTRES', items: [
          Item(id: 'a_queso', name: 'QUESO', price: 7.0),
          Item(id: 'b_magia_negra', name: 'MAGIA NEGRA', price: 6.0),
          Item(id: 'c_brownie', name: 'BROWNIE', price: 6.0),
          Item(id: 'd_zanahoria', name: 'BROWNIE', price: 6.0),
          Item(id: 'e_fruta', name: 'FRUTA', price: 18.0),
          Item(id: 'f_magnun_blanco', name: 'MAGNUN BLANCO', price: 0.0),
          Item(id: 'g_caramelo', name: 'CARAMELO', price: 0.0),
          Item(id: 'h_chocolate', name: 'CHOCOLATE', price: 0.0),
          Item(id: 'i_almendrado', name: 'ALMENDRADO', price: 0.0),
          Item(id: 'j_fantasmicos', name: 'FANTASMICOS', price: 0.0),
          Item(id: 'k_lapiz', name: 'LAPIZ', price: 0.0),
          Item(id: 'l_pirulo', name: 'PIRULO', price: 0.0),
          Item(id: 's_vainilla', name: 'VAINILLA', price: 0.0),
          Item(id: 't_chocolate', name: 'CHOCOLATE', price: 0.0),
          Item(id: 'u_frambuesa', name: 'FRAMBUESA', price: 0.0),
          Item(id: 'v_kinder', name: 'KINDER', price: 0.0),
          Item(id: 'w_no_sirope', name: 'NO SIROPE', price: 0.0)
        ]),
      ],
    );

    return Scaffold(
        body: Container(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFFB0D5FF)),
        ),
        onPressed: () {
          addCategory(comidas);
        },
        child: const SizedBox(
          width: 290,
          height: 190,
          child: Align(
            child: Text(
              'IMPR CUENTA',
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
