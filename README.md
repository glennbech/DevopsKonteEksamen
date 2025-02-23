# PGR301 DevOps i skyen -Gjentak: 72 timers skriftlig individuell hjemmeeksamen

1) Jeg har valgt å ta i bruk "environment variable" i GitHub for å forhindre at "secrets" som ikke burde bli delt forblir skjult ettersom hardkodede "secrets" er et sikkerhetsproblem. Siden "secrets" blir referert til i koden så vil de ikke vises i koden og takket være GitHub så vil de heller ikke bli vist i loggen.
    </br></br>
2) Jeg har bestemt meg for å overvåke vg.no og xkcd.com sin uptime. Har laget en modul som kan bli tatt i bruk flere ganger for statuscake_uptime_check. Siden disse sidene ikke er kritiske tjenester så kommer jeg til å beholde intervalet på 5 minutter samt med de andre terskelverdiene. 3 konfirmasjons sjekker, 10 sjekker før en varsel blir sendt ut og en timeout på 20 sekunder.
   </br></br>
3) </br></br>
4) Hvis man er i en tidlig start fase kan det fungere å lagre .tfstate filen lokalt, men det hindrer utvikleren fra å har en historie over hvordan .tfstate filen har forandret seg gjenom flere kjøringer av Terraform.
Github, som jeg bruker, fungerer for å huske hvordan .tfstate filen har forandret seg, men ettersom den skriver over seg selv hver eneste gang så er ikke det optimalt; derfor påstår jeg at det er mer effektivt å ta i bruke en backend serice for å håndtere lagring av hver versjon av .tfstate filen. </br>
Med oppsettet jeg bruker nå, med GitHub, så er ikke det bra for å jobbe med flere personer samtidig ettersom bare en versjon av .tfstate fil kan finnes om gangen på GitHub; Men dette lar også alle som jobber på prosjektet enkelt hente den nyeste versjonen av .tfstate filen, men det er bare så lenge man henter inn den versjonen fra, i mitt tilfelle, den nyeste versjonen av main branchen. Men det kan også oppnås ved å bruke en backend service der man har alle versjonene av .tfstate filen så kan personer på temaet heller hente ut versjonen de trenger fra backend servicen istedenfor å måtte hente ut den nyeste versjonen fra main branchen. </br></br>
