{* preload the headers (for faster browsing) *}

{include file=$path|cat:'../header.tpl'}


	<div id="login">
		<div id="login-window">
			<div class="login-logo"></div>
			<div class="login-title"></div>
			<form id="frmLogin" name="frmLogin" action="" method="post">
				<input type="hidden" name="action" value="login" />

				<div class="login-field">
					<span class="login-label1">{$LANG.email}:</span>
					<input name="user" id="name-field" type="text" title="E-mail" spellcheck="false" maxlength="255" autocomplete="off"></input>
				</div>
				<div class="login-field">
					<span class="login-label2">{$LANG.password}:</span>
					<input name="pass" id="password-field" type="password" title="Heslo" spellcheck="false" maxlength="255" autocomplete="off"></input>
					<div class="login-submit">
						<input type="submit" id="btn-login" alt="Login" title="Přihlásit…" value="" ></input>
					</div>
				</div>
				{if $errorMessage }
					<p class="warning">{$errorMessage|outhtml}!</p>
				{/if}
			</form>
		</div>
	</div>


{literal}
<script language="JavaScript">
	$(document).ready(function(){
		w_h = $(window).height();
		var m_top = ( w_h > 599 ) ? '100px' : '30px';
		$('.si_box, #login-window').css('margin-top','-600px');
		$('.si_box, #login-window').animate({ 'marginTop':m_top }, 1500);
		$('#login input[type="text"], #login input[type="password"]').attr('style',
			'background-color: transparent !important; -webkit-text-fill-color: #333 !important;'
			);
		// $('#login input[type="text"], #login input[type="password"]').attr('autocomplete','off');

		$('#btn-login').click(function(event){
			event.preventDefault();
			$('.si_box, #login-window').animate({ 'marginTop':'-600px'}, 500, function(){
				$('form#frmLogin').submit();
			});
		});
		$(window).resize(function() {
			w_h = $(window).height();
			var m_top = ( w_h > 599 ) ? '100px' : '30px';
			$('.si_box, #login-window').css('margin-top',m_top);
		});
        });
	document.frmLogin.user.focus();
</script>
{/literal}

</body>
</html>
