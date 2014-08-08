:Class Index : Blank
⍝Blank MiServer page that will be called from GitHub

    :Include #.HTMLInput
    :Include #.JSON

        CRFL←⎕UCS 13 10

    ∇ Render req;html;json;form
      :Access Public
      html←'Dyalog Deployment Server!',CRFL
      html,←'This page should only be called from Github, if you''re seeing this, sod-off!',CRFL
      html,←'Running on MiServer2.',CRFL

      ret←req.Data[;2]          ⍝ This is the returned Data from Github
      json←⊃ret

     :If 0<⍴json                ⍝ Data isn't nothing...
       #.aa←json                        ⍝ Let me sod about with it in the session
       GitHubJSON←JSONtoNS json
     :EndIf

      html,←'<br/>TESTING</br>'
      html,←'<form action="index.dyalog" method="post">'
      html,←'<textarea name="payload" rows="30" cols="150"></textarea><br />'
      html,←'<input type="submit">'
      html,←'</form>'
      req.Return html
    ∇



:EndClass

