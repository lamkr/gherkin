import groovy.text.SimpleTemplateEngine
import groovy.json.JsonSlurper
import groovy.transform.Field

import java.nio.file.Files

@Field
def project_basedir = "/home/luciano/projects/lamkr/gherkin/java"

SimpleTemplateEngine engine = new SimpleTemplateEngine()
//def templateSource = new File(project.basedir, "src/main/groovy/io/cucumber/gherkin/GherkinDialects.gsp").getText()
def templateSource = new File(project_basedir, "src/main/groovy/io/cucumber/gherkin/GherkinDialects.gsp").getText()

def jsonSlurper = new JsonSlurper()
//def dialects = jsonSlurper.parseText(new File(project.basedir, "../gherkin-languages.json").getText())
def dialects = jsonSlurper.parseText(new File(project_basedir, "../gherkin-languages.json").getText())
def arrToString(arr) {
    return arr.collect {e -> return '"' + e + '"'}.join(", ")
}
def binding = ["dialects": dialects, "arrToString": this.&arrToString]

def template = engine.createTemplate(templateSource).make(binding)
//def file = new File(project.basedir, "target/generated-sources/gherkin-dialects/java/io/cucumber/gherkin/GherkinDialects.java")
def file = new File(project_basedir, "src/main/java/io/cucumber/gherkin/GherkinDialects.java")
Files.createDirectories(file.parentFile.toPath())
file.write(template.toString(), "UTF-8")
