# PGR301 DevOps i skyen -Gjentak: 72 timers skriftlig individuell hjemmeeksamen

1) Jeg har valgt å ta i bruk "environment variable" i GitHub for å forhindre at "secrets" som ikke burde bli delt forblir skjult ettersom hardkodede "secrets" er et sikkerhetsproblem. Siden "secrets" blir referert til i koden så vil de ikke vises i koden og takket være GitHub så vil de heller ikke bli vist i loggen.
</br></br>
2) Jeg har bestemt meg for å overvåke vg.no og xkcd.com sin uptime. Har laget en modul som kan bli tatt i bruk flere ganger for statuscake_uptime_check. Siden disse sidene ikke er kritiske tjenester så kommer jeg til å beholde intervalet på 5 minutter samt med de andre terskelverdiene. 3 konfirmasjons sjekker, 10 sjekker før en varsel blir sendt ut og en timeout på 20 sekunder.