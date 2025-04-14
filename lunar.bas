'lunar.bas
' Original code by Creative Computing, Morristown, New Jersey
' Updated code by Chris Stoddard

PRINT TAB(33);"LUNAR"
PRINT TAB(15);"CREATIVE COMPUTING MORRISTOWN, NEW JERSEY"
PRINT: PRINT: PRINT

PRINT "THIS IS A COMPUTER SIMULATION OF AN APOLLO LUNAR"
PRINT "LANDING CAPSULE.": PRINT: PRINT
PRINT "THE ON-BOARD COMPUTER HAS FAILED (IT WAS MADE BY"
PRINT "XEROX) SO YOU HAVE TO LAND THE CAPSULE MANUALLY."
PRINT: PRINT "SET BURN RATE OF RETRO ROCKETS TO ANY VALUE BETWEEN"
PRINT "0 (FREE FALL) AND 200 (MAXIMUM BURN) POUNDS PER SECOND."
PRINT "SET NEW BURN RATE EVERY 10 SECONDS.": PRINT
PRINT "CAPSULE WEIGHT 32,500 LBS; FUEL WEIGHT 16,500 LBS."
PRINT: PRINT: PRINT "GOOD LUCK"

DO
    timeSec = 0
    altitude = 120
    velocity = 1
    totalMass = 33000
    fuelMass = 16500
    gravity = 1E-03
    thrustFactor = 1.8

    PRINT: PRINT "SEC","MI + FT","MPH","LB FUEL","BURN RATE"
    PRINT

    DO
        miles = INT(altitude)
        feet = INT(5280 * (altitude - miles))
        mph = 3600 * velocity
        fuelRemaining = totalMass - fuelMass

        PRINT timeSec, miles; "+"; feet, mph, fuelRemaining;
        INPUT " ", burnRate

        burnTime = 10
        IF fuelRemaining < 1E-03 THEN GOTO NoFuel

        DO WHILE burnTime >= 1E-03
            IF totalMass < fuelMass + burnTime * burnRate THEN
                burnTime = (totalMass - fuelMass) / burnRate
            END IF

            ' Calculate thrust acceleration and update states
            q = burnTime * burnRate / totalMass
            nextVelocity = velocity + gravity * burnTime + thrustFactor * (-q - q^2/2 - q^3/3 - q^4/4 - q^5/5)
            nextAltitude = altitude - gravity * burnTime^2 / 2 - velocity * burnTime + thrustFactor * burnTime * (q/2 + q^2/6 + q^3/12 + q^4/20 + q^5/30)

            IF nextAltitude <= 0 THEN GOTO SoftLanding
            IF velocity <= 0 AND nextVelocity > 0 THEN GOTO BurnCorrection

            ' Apply state update
            timeSec = timeSec + burnTime
            burnTime = 0
            totalMass = totalMass - burnRate * burnTime
            altitude = nextAltitude
            velocity = nextVelocity
        LOOP
    LOOP

NoFuel:
    PRINT "FUEL OUT AT"; timeSec; "SECONDS"
    burnTime = (-velocity + SQR(velocity^2 + 2 * altitude * gravity)) / gravity
    velocity = velocity + gravity * burnTime
    timeSec = timeSec + burnTime
    impactVelocity = 3600 * velocity
    PRINT "ON MOON AT"; timeSec; "SECONDS - IMPACT VELOCITY"; impactVelocity; "MPH"

    IF impactVelocity <= 1.2 THEN
        PRINT "PERFECT LANDING!"
    ELSEIF impactVelocity <= 10 THEN
        PRINT "GOOD LANDING (COULD BE BETTER)"
    ELSEIF impactVelocity <= 60 THEN
        PRINT "CRAFT DAMAGE... YOU'RE STRANDED UNTIL A RESCUE PARTY ARRIVES."
        PRINT "HOPE YOU HAVE ENOUGH OXYGEN!"
    ELSE
        PRINT "SORRY, THERE WERE NO SURVIVORS. YOU BLEW IT!"
        PRINT "YOU BLASTED A NEW LUNAR CRATER"; impactVelocity * 0.227; "FEET DEEP!"
    END IF

    GOTO TryAgainPrompt

BurnCorrection:
    w = (1 - totalMass * gravity / (thrustFactor * burnRate)) / 2
    burnTime = totalMass * velocity / (thrustFactor * burnRate * (w + SQR(w^2 + velocity / thrustFactor))) + 0.05
    GOTO NoFuel ' Reuse landing logic

SoftLanding:
    IF burnTime < 5E-03 THEN GOTO NoFuel

    decel = velocity + SQR(velocity^2 + 2 * altitude * (gravity - thrustFactor * burnRate / totalMass))
    burnTime = 2 * altitude / decel

    ' Recalculate and update state
    q = burnTime * burnRate / totalMass
    nextVelocity = velocity + gravity * burnTime + thrustFactor * (-q - q^2/2 - q^3/3 - q^4/4 - q^5/5)
    nextAltitude = altitude - gravity * burnTime^2 / 2 - velocity * burnTime + thrustFactor * burnTime * (q/2 + q^2/6 + q^3/12 + q^4/20 + q^5/30)

    timeSec = timeSec + burnTime
    totalMass = totalMass - burnRate * burnTime
    altitude = nextAltitude
    velocity = nextVelocity
    GOTO NoFuel

TryAgainPrompt:
    PRINT: PRINT: PRINT "TRY AGAIN? (Y/N)";
    INPUT retry$
LOOP WHILE UCASE$(retry$) = "Y"

END
