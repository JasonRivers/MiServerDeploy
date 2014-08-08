:Class Index : Blank
⍝Blank MiServer page that will be called from GitHub

    :Include #.HTMLInput
    :Include #.JSON

        CRLF←⎕UCS 13 10

    ∇ Render req;html;json;form
      :Access Public
      html←'Dyalog Deployment Server!',CRLF
      html,←'This page should only be called from Github, if you''re seeing this, bog-off!',CRLF
      html,←'Running on MiServer2.',CRLF

      json←⊃req.Data[;2]                ⍝ This is the returned Data from Github

     :If 0<⍴json                        ⍝ Data isn't nothing...
       #.aa←json                        ⍝ Let me sod about with it in the session
       GitHubData←⎕XML #.JSON.JSONtoXML json ⍝ Convert our json to an APL Array (The long way for now while JSONtoOBJ isn't working)

       :If ({⍵⍳⊂'ref'}(,GitHubData))<(⍴(,GitHubData))
         :If 'refs/heads/Staging' ≡⊃GitHubData[2;3]
                        ⍝ Something was pushed to "Staging", we want to restart our staging server here
                html,←'Running Code for Staging',CRLF
         :ElseIf 'refs/heads/Live' ≡⊃GitHubData[2;3]
                        ⍝ Something was pushed to "Live", We want to restart our live server here
                html,←'Running Code for Live',CRLF
         :EndIf
        :Else
                html,←'Nothing to do here...',CRLF
        :EndIf
      :EndIf

      html,←'<br/>TESTING</br>'
      html,←'<form action="index.dyalog" method="post">'
      html,←'<textarea name="payload" rows="30" cols="150"></textarea><br />'
      html,←'<input type="submit">'
      html,←'</form>'
      req.Return html
    ∇



:EndClass

