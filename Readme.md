<center><a href="https://otterkring.github.io/MainPage" style="font-size:75%;">return to MainPage</a></center>

# Start-Countdown / Add a custom visible countdown to your script
## Show the user how long (s)he has to wait until something new happens


### Why ...

Sometimes in your code it makes sense to just sit and wait for things to happen, adjust themselves or similar before you continue doing anything.

The most common way to do that is to just add a ...

    Start-Sleep -Seconds 5

... in your code or some ...

    while (Get-ADComputer MyPC01) {
        Start-Sleep -Seconds 3
    }

... to check when the deletion of a computer object (e.g. by SCCM) in Active Directory has replicated to your server.

This is fine if you are doing it for yourself. But if you are coding for someone else, you might somehow want to show him/her, that the script is still active, though just waiting for something else to happen. Personally I get nervous, if nothing happens on my console for a longer time.

So, to satisfy this "Hey! Talk to me!" voice in the user, you could e.g. add to the above example like this:

    while (Get-ADComputer MyPC01) {
        Write-Host '.' -NoNewLine
        Start-Sleep -Seconds 3
    }

Or as a oneliner in the console:

    while (Get-ADComputer MyPC01) {Write-Host '.' -NoNewLine; Start-Sleep -Seconds 3}

This will at least draw a dot every 3 seconds to show the user "something is happening".


### "Lift-Off in T minus 10 seconds!"

> "Nothing really practical can ever be ugly." (Otto Wagner)

Personally I prefer pretty output in scripts, especially if they should be reused by other people.

While writing my [Watch-Command](https://otterkring.github.io/PS_Watch-Command/) function I created a basic bar-countdown (or count-up, rather) to make an equivalent of the above while-loop a bit prettier. It soon added up to a little helper function, which lets me choose from three different countdowns and a customizable countdown range.

Enter `Start-CountDown`!

You can use it practically everywhere in your script, where you use output to the powershell console and have to wait for something.
The function returns the cursors Y position where it was called as a `[PSCustomObject]`, so you can continue your output overwriting the countdown if you want. If you don't care, just point it to $Null:

    $CursorY = (Start-Countdown -Seconds 10 -Type Bar).CursorY

    $Null = Start-Countdown -Seconds 5 -Type Numeric

    $Null = Start-Countdown -Seconds 120 -Type HalfBar

`Start-CountDown` defaults to a 10 second countdown of type `Bar`. If your interval exceeds the number of characters of half of your window width it will autodefault to the `HalfBar` Type to save space. `Numeric` just counts down in numbers.


Good luck and happy coding!
Max.
