/* 
 * Copyright (C) 2014 Vasilis Vryniotis <bbriniotis at datumbox.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package Analayse.com.datumbox.opensource.examples;

import Analayse.com.datumbox.opensource.classifiers.NaiveBayes;
import Analayse.com.datumbox.opensource.dataobjects.NaiveBayesKnowledgeBase;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Vasilis Vryniotis <bbriniotis at datumbox.com>
 * @see <a href="http://blog.datumbox.com/developing-a-naive-bayes-text-classifier-in-java/">http://blog.datumbox.com/developing-a-naive-bayes-text-classifier-in-java/</a>
 */
public class NaiveBayesExample {

    /**
     * Reads the all lines from a file and places it a String array. In each 
     * record in the String array we store a training example text.
     * 
     * @param url
     * @return
     * @throws IOException 
     */
    public static String[] readLines(URL url) throws IOException {

        Reader fileReader = new InputStreamReader(url.openStream(), Charset.forName("UTF-8"));
        List<String> lines;
      BufferedReader bufferedReader = new BufferedReader(fileReader) ;
      
            lines = new ArrayList<String>();
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                lines.add(line);
            }
        
        return lines.toArray(new String[lines.size()]);
    }
    
    /**
     * Main method
     * 
     * @param args the command line arguments
     * @throws java.io.IOException
     */
    public static void main(String[] args) throws IOException {
        //map of dataset files
           long startTime = System.currentTimeMillis();
        Map<String, URL> trainingFiles = new HashMap<String, URL>();
       // trainingFiles.put("DELTA COMPANY", NaiveBayesExample.class.getResource("/datasets/training.stock.delta.txt"));
        trainingFiles.put("POSITIVE MOOD", NaiveBayesExample.class.getResource("/datasets/positive.txt"));
        trainingFiles.put("NEGATIVE MOOD", NaiveBayesExample.class.getResource("/datasets/negative.txt"));
        
        //loading examples in memory
        Map<String, String[]> trainingExamples = new HashMap<String, String[]>();
        for(Map.Entry<String, URL> entry : trainingFiles.entrySet()) {
            trainingExamples.put(entry.getKey(), readLines(entry.getValue()));
        }
        
        //train classifier
        NaiveBayes nb = new NaiveBayes();
        nb.setChisquareCriticalValue(1.63); //0.01 pvalue
        nb.train(trainingExamples);
        
        
        //get trained classifier knowledgeBase
        NaiveBayesKnowledgeBase knowledgeBase = nb.getKnowledgeBase();
        
        //nb = null;
      //  trainingExamples = null;
        
        
        //Use classifier
        nb = new NaiveBayes(knowledgeBase);
        String exampleEn = "It was a very good receipe";
        String outputEn = nb.predict(exampleEn);
        
       // System.out.format("The company \"%s\" was classified as \"%s\".%n", exampleEn, outputEn);
          System.out.format("The Moode  \"%s\" was classified as \"%s\".%n", exampleEn, outputEn);
        /*
        String exampleFr = "800";
        String outputFr = nb.predict(exampleFr);
        System.out.format("The sentense \"%s\" was classified as \"%s\".%n", exampleFr, outputFr);
        //format of input data
        // company_name stock value datedd/m/yyyy
        String exampleDe = "906";
        String outputDe = nb.predict(exampleDe);
        System.out.format("The sentense \"%s\" was classified as \"%s\".%n", exampleDe, outputDe);
        
*/
long endTime   = System.currentTimeMillis();
long totalTime = endTime - startTime;
System.out.println(totalTime+" ms"+((Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory())/1024)+"KB");

    }
    
}
