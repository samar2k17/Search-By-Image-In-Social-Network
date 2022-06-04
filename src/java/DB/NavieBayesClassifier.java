package DB;

import Analayse.com.datumbox.opensource.classifiers.NaiveBayes;
import Analayse.com.datumbox.opensource.dataobjects.NaiveBayesKnowledgeBase;
import static Analayse.com.datumbox.opensource.examples.NaiveBayesExample.readLines;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author DKG
 */
public class NavieBayesClassifier {
    public static void main(String args[]){
    analayseData("This is bad");
    }
     public static String preProcessTexts(String text) {
        text = text.replaceAll("\\bI\\b", "").trim();
        text = text.replaceAll("\\ba\\b", "").trim();
        text = text.replaceAll("\\bthe\\b", "").trim();
        text = text.replaceAll("\\bis\\b", "").trim();
        text = text.replaceAll("\\bam\\b", "").trim();
        text = text.replaceAll("\\bare\\b", "").trim();
        text = text.replaceAll("\\bthey\\b", "").trim();
        text = text.replaceAll("\\bthose\\b", "").trim();
        text = text.replaceAll("\\bthis\\b", "").trim();
        text = text.replaceAll("\\bwas\\b", "").trim();
        text = text.replaceAll("\\bit\\b", "").trim();
        text = text.replaceAll("\\s+", " ");
        return text;
    }
     
     public static NaiveBayes load(){
     NaiveBayes nb=null;
         try {
                Map<String, URL> trainingFiles = new HashMap<String, URL>();
        trainingFiles.put("positive", NavieBayesClassifier.class.getResource("/datasets/positive.txt"));
        trainingFiles.put("neutral", NavieBayesClassifier.class.getResource("/datasets/neutral.txt"));
        trainingFiles.put("negative", NavieBayesClassifier.class.getResource("/datasets/negative.txt"));
      
        
        //loading examples in memory
        Map<String, String[]> trainingExamples = new HashMap<String, String[]>();
        for(Map.Entry<String, URL> entry : trainingFiles.entrySet()) {
            trainingExamples.put(entry.getKey(), readLines(entry.getValue()));
        }
        
        //train classifier
         nb = new NaiveBayes();
        nb.setChisquareCriticalValue(1.67); //0.01 pvalue
        nb.train(trainingExamples);
        
        //get trained classifier knowledgeBase
        NaiveBayesKnowledgeBase knowledgeBase = nb.getKnowledgeBase();
        
        //nb = null;
      //  trainingExamples = null;
        
        
        //Use classifier
        nb = new NaiveBayes(knowledgeBase);
         } catch (Exception e) {
         }
         return nb;
     }
     //-0.3502594241041286
    public static String analayseData(String input){
       input= preProcessTexts(input.toLowerCase());
       System.out.println("input removed "+input);
          String output = null;
        try{
          Map<String, URL> trainingFiles = new HashMap<String, URL>();
        trainingFiles.put("positive", NavieBayesClassifier.class.getResource("/datasets/positive.txt"));
        trainingFiles.put("neutral", NavieBayesClassifier.class.getResource("/datasets/neutral.txt"));
        trainingFiles.put("negative", NavieBayesClassifier.class.getResource("/datasets/negative.txt"));
      
        
        //loading examples in memory
        Map<String, String[]> trainingExamples = new HashMap<String, String[]>();
        for(Map.Entry<String, URL> entry : trainingFiles.entrySet()) {
            trainingExamples.put(entry.getKey(), readLines(entry.getValue()));
        }
        
        //train classifier
        NaiveBayes nb = new NaiveBayes();
        nb.setChisquareCriticalValue(1.67); //0.01 pvalue
        nb.train(trainingExamples);
        
        //get trained classifier knowledgeBase
        NaiveBayesKnowledgeBase knowledgeBase = nb.getKnowledgeBase();
        
        //nb = null;
      //  trainingExamples = null;
        
        
        //Use classifier
        nb = new NaiveBayes(knowledgeBase);
        
         output = nb.predict(input);
         double d=nb.getChisquareCriticalValue();
         double d1=nb.getMaxScore();
            System.out.println("critical values="+d+" max score="+d1);
       // System.out.format("The company \"%s\" was classified as \"%s\".%n", exampleEn, outputEn);
          System.out.format("The Moode  \"%s\" was classified as \"%s\".%n", input, output);
        }catch(Exception e){}
    return output;
    }
}
