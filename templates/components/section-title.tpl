{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'section-title'}

{block name='section_title'}
  <h2 class="h2 {$componentName}">{$title}</h2>
  {if isset($link)}
    <a class="all-product-link btn btn-outline-primary" href="{$link}">
      {l s='All products' d='Shop.Theme.Catalog'}<i class="material-icons rtl-flip" aria-hidden="true">&#xE315;</i>
    </a>
  {/if}
{/block}
