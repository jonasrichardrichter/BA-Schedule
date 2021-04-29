# Important information for the beta use

The current beta version is **0.1.1**

The version represants an early proof of concept build. The main functions are working but there is no error handling currently.

Please provide the your correct information during login!

Known issues can be found in the GitHub issues tab of this repository. Feel free to add any bug you foun.

## How do I get the hash?

Getting the hash is currently the most annoying part of the setup. The reason for this is that the hash can only be read using the developer functions in a browser. 
Work is already underway to provide a more elegant method for logging in soon.

The current process is:

1. open Campus-Dual in your browser and then log in with your usual credentials.

2. open the network console of your browser. There are several ways to do this depending on your browser. In the Google Chrome browser, press 'F12' and then select the Network tab. 

3. Now click on Timetable > Plan View on the Campus Dual website. 

4. now look for an entry in the list that starts with `json` and select it.

5. Now select Header and scroll down to the item Query string parameters.

6. Copy the displayed value to `hash:` and enter it into the app.

Now the app should work and be able to retrieve your timetable!


# GERMAN

Die aktuelle Beta-Version ist **0.1.1**.

Die Version stellt einen frühen Proof-of-Concept-Build dar. Die Hauptfunktionen sind funktionsfähig, aber es gibt derzeit keine Fehlerbehandlung.

Bitte gib bei der Anmeldung die korrekten Daten an!

Bekannte Fehler findest du in der GitHub-Registerkarte "Issues" in diesem Repository. Falls du Fehler findest, füge ihn gerne hinzu.

## Wie bekomme ich den Hash?

Den Hash zu erhalten stellt aktuell den nervigsten Teil des Setups dar. Dies hat den Grund, dass der Hash nur mittels der Entwicklerfunktionen in einem Browser auslesbar ist. 
Es wird bereits daran gearbeitet demnächst eine elegantere Methode zur Anmeldung zur Verfügung zu stellen.

Der aktuelle Prozess lautet:

1. Öffne Campus-Dual in deinem Browser und melde dich anschließend mit deinen gewohnten Anmeldedaten an.

2. Öffne die Netzwerkkonsole deines Browsers. Dabei gibt es mehrere Varianten dies zu tun abhängig von deinem Browser. Im Google Chrome Browser drückst du `F12` und wählst dann den Reiter Netzwerk an. 

3. Klicke nun auf der Campus Dual Website auf Stundenplan > Planansicht. 

4. Suche nun in der Liste einen Eintrag, welcher mit `json` beginnt und wähle diesen aus.

5. Wähle nun Kopfzeilen und scrolle nach unten zum Punkt Abfragezeichenfolge-Parameter.

6. Kopiere dir den angezeigten Wert nach `hash:` und trage ihn in die App ein.

Nun sollte die App funktionieren und deinen Stundenplan abrufen können!
