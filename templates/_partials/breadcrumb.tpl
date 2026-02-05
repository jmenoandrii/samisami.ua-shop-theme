{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
 {$componentName = 'breadcrumb'}

<nav data-depth="{$breadcrumb.count}" class="{$componentName}" aria-label="{$componentName}">
  <ol class="{$componentName}-container sami-container">
    {block name='breadcrumb'}
      {foreach from=$breadcrumb.links item=path name=breadcrumb}
        {block name='breadcrumb_item'}
          <li class="{$componentName}-item">
            {if not $smarty.foreach.breadcrumb.last}
              <a href="{$path.url}" class="{$componentName}-link">{$path.title}</a>
            {else}
              <span>{$path.title}</span>
            {/if}
          </li>
        {/block}
      {/foreach}
    {/block}
  </ol>
</nav>
