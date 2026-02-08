{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{assign var="increment_icon" value="add"}
{assign var="decrement_icon" value="remove"}
{assign var="submit_icon" value="check"}
{assign var="cancel_icon" value="close"}

{* The spin button placement for RTL should be same as LTR *}
{* To fix mirroring by CSS need to place them in reverse for RTL *}
{if $language.is_rtl}
  {assign var="prepend" value=["button"=>"increment", "icon"=>$increment_icon, "confirm_icon"=>$submit_icon]}
  {assign var="append" value=["button"=>"decrement", "icon"=>$decrement_icon, "confirm_icon"=>$cancel_icon]}
{else}
  {assign var="prepend" value=["button"=>"decrement", "icon"=>$decrement_icon, "confirm_icon"=>$cancel_icon]}
  {assign var="append" value=["button"=>"increment", "icon"=>$increment_icon, "confirm_icon"=>$submit_icon]}
{/if}

<div class="sami-input-group">
  <button role="button" aria-label="{$prepend.button}" class="{$prepend.button} js-{$prepend.button}-button" type="button">
    <i class="material-symbols-outlined" aria-hidden="true">{$prepend.icon}</i>
    <i class="material-symbols-outlined confirmation d-none">{$prepend.confirm_icon}</i>
    <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
  </button>

  <input
    {foreach $attributes as $key=>$value}
      {$key}="{$value}"
    {/foreach}
    {* The default attributes, will be used if not defined *}
      class="form-control"
      name="qty"
      aria-label="{l s='Quantity' d='Shop.Theme.Actions'}"
      type="text"
      inputmode="numeric"
      pattern="[0-9]*"
      value="1"
      min="1"
    {* End of default attributes *}
  />

  <button role="button" aria-label="{$append.button}" class="{$append.button} js-{$append.button}-button" type="button">
    <i class="material-symbols-outlined" aria-hidden="true">{$append.icon}</i>
    <i class="material-symbols-outlined confirmation d-none">{$append.confirm_icon}</i>
    <div class="spinner-border spinner-border-sm align-middle d-none" role="status"></div>
  </button>
</div>
