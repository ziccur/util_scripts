/* 
*    Este programa es un simple script para calcular el porcentage de faltas asumible en el instituto donde estudiamos, es un programa personal
*    sin otros fines que para nuestro uso.
*
*    Use: java controlAssist <horas asistidas> <ausencias> <>quantas horas quieres faltar>
*
*   Este programa utiliza una version de scanner llamada "Entrada" que es un script privado
*/

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class controlAssist {

    public static void main(String[] args){
        
        int asistencias = Integer.parseInt(args[0]);
        int ausencias = Integer.parseInt(args[1]);
        int horas = Integer.parseInt(args[2]);

        int porcentageParaAprobar = 80;

        float porFaltas = (float) ausencias / (asistencias+ausencias) * 100;
        float porFaltasActualizado = (float) (ausencias + horas) / (asistencias+ausencias) * 100;
        porFaltas = (float) 100.00 - porFaltas;
        porFaltasActualizado = (float) 100.00 - porFaltasActualizado;

        mostrarResultado(porFaltas, porFaltasActualizado, porcentageParaAprobar);

    }

    public static String readLine() {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            String line = reader.readLine();
            if (line == null) {
                throw new RuntimeException("S'ha cridat massa cops Entrada.readLine()");
            }
            return line;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static void imprimirLinia(){
        for(int i=0 ; i < 55; i++){
            System.out.print("#");
        }System.out.println();
        System.out.println();
    }

    public static void mostrarResultado(float faltas, float faltasNuevas, int aprobar){
        imprimirLinia();
        if(faltasNuevas < aprobar){
            System.out.println("            MENOS DEL " + aprobar + "% DE ASISTENCIA");
        }else System.out.println("              APRUEBAS POR ASISTENCIA");
        System.out.println();
        System.out.println("               " + faltas + " -> " + faltasNuevas); 
        imprimirLinia();
    }

    public static String horasUf(String modulo){

        // AÑO 1 
        String[] M01 = {"UF1:49", "UF2:69" , "UF3:14"}; // FARO
        String[] M02 = {"UF1:25", "UF2:58" , "UF3:66", "UF4:16"}; // JORDI
        String[] M03 = {"UF1:75", "UF2:60", "UF3:21", "UF4:24", "UF5:33", "UF6:18"}; //MOISES
        String[] M04 = {"UF1:45", "UF2:27" , "UF3:27"}; // Pau GG
        String[] M05 = {"UF1:20", "UF2:20" , "UF3:26"}; // Moises
        return "error";
    }
}