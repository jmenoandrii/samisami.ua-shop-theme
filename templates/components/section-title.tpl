{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'section-title'}

{block name='section_title'}
  <div class="{$componentName}__container">
    <h2 class="h2 {$componentName}">{$title}</h2>
    {if isset($sectionLink)}
      <a class="{$componentName}__link" href="{$sectionLink}">
        {l s='All products' d='Shop.Theme.Catalog'}
        →
      </a>
    {/if}
  </div>
{/block}
