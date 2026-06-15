---
icon: fa-solid fa-car
order: 5
title: Vehicle prices
---

{% assign shop = site.data.shop_prices %}
{% assign vehicles = shop.Vehicles | default: shop.vehicles %}

<style>
	#shop-vehicles-list table {
		width: 100%;
	}

	#shop-vehicles-list .search {
		max-width: 28rem;
		margin-bottom: 0.75rem;
	}

	#shop-vehicles-list tbody tr {
		height: 48px;
	}

	#shop-vehicles-list tbody td {
		vertical-align: middle;
	}

	#shop-vehicles-list .icon-cell {
		width: 56px;
	}

	#shop-vehicles-list .icon-image {
		display: block;
		width: auto;
		height: auto;
		max-width: 48px;
		max-height: 48px;
		margin: 0 auto;
	}

	#shop-vehicles-list .table-sort-btn {
		display: inline-flex;
		align-items: center;
		gap: 0.35rem;
		padding: 0;
		border: 0;
		background: transparent;
		font: inherit;
		font-weight: 600;
		color: inherit;
		line-height: 1.2;
	}

	#shop-vehicles-list .table-sort-btn:hover,
	#shop-vehicles-list .table-sort-btn:focus-visible {
		text-decoration: none;
		opacity: 0.9;
	}

	#shop-vehicles-list .sort-indicator {
		font-size: 0.85rem;
		opacity: 0.7;
	}

	#shop-vehicles-list .table-sort-btn.asc .sort-indicator,
	#shop-vehicles-list .table-sort-btn.desc .sort-indicator {
		opacity: 1;
	}
</style>

<div id="shop-vehicles-list">
	<p>
		<input class="search form-control" type="search" placeholder="Search vehicles..." aria-label="Search vehicles">
	</p>
	<table>
		<thead>
			<tr>
				<th>Icon</th>
				<th>
					<button class="sort table-sort-btn" data-sort="vehicle-type" type="button"><span>Type</span><i class="sort-indicator fa-solid fa-sort" aria-hidden="true"></i></button>
				</th>
				<th>
					<button class="sort table-sort-btn" data-sort="vehicle-id" type="button"><span>ID</span><i class="sort-indicator fa-solid fa-sort" aria-hidden="true"></i></button>
				</th>
				<th>
					<button class="sort table-sort-btn" data-sort="vehicle-name" type="button"><span>Vehicle</span><i class="sort-indicator fa-solid fa-sort" aria-hidden="true"></i></button>
				</th>
				<th>
					<button class="sort table-sort-btn" data-sort="vehicle-buy" type="button"><span>Buy</span><i class="sort-indicator fa-solid fa-sort" aria-hidden="true"></i></button>
				</th>
			</tr>
		</thead>
		<tbody class="list">
			{% if vehicles and vehicles.size > 0 %}
				{% for vehicle in vehicles %}
					{% assign vehicle_buy = vehicle.BuyPrice | default: 0 | plus: 0 %}
					{% assign vehicle_url = vehicle.url %}
					<tr>
						<td class="icon-cell">
							{% if vehicle.iconUrl %}
								<img class="icon-image" src="{{ vehicle.iconUrl }}" alt="{{ vehicle.VehicleName | default: vehicle.Name }}" loading="lazy">
							{% endif %}
						</td>
						<td class="vehicle-type">{{ vehicle.assetType }}</td>
						<td class="vehicle-id">{{ vehicle.ID }}</td>
						<td class="vehicle-name">
							{% if vehicle_url %}
								<a href="https://restoremonarchy.com{{ vehicle_url }}" target="_blank" rel="noopener noreferrer">{{ vehicle.VehicleName | default: vehicle.Name }}</a>
							{% else %}
								{{ vehicle.VehicleName | default: vehicle.Name }}
							{% endif %}
						</td>
						<td class="vehicle-buy">{{ vehicle_buy | round: 0 }}</td>
					</tr>
				{% endfor %}
			{% else %}
				<tr>
					<td class="icon-cell"></td>
					<td class="vehicle-type"></td>
					<td class="vehicle-id"></td>
					<td class="vehicle-name">No vehicles available</td>
					<td class="vehicle-buy"></td>
				</tr>
			{% endif %}
		</tbody>
	</table>
</div>

<script>
	(function () {
		function loadListJs(onReady) {
			if (window.List) {
				onReady();
				return;
			}

			var script = document.createElement('script');
			script.src = 'https://cdn.jsdelivr.net/npm/list.js@2.3.1/dist/list.min.js';
			script.defer = true;
			script.onload = onReady;
			document.head.appendChild(script);
		}

		function createSortFunction(numericFields) {
			return function (a, b, options) {
				var valueName = options.valueName;
				var left = (a.values()[valueName] || '').toString().trim();
				var right = (b.values()[valueName] || '').toString().trim();

				if (numericFields.indexOf(valueName) !== -1) {
					var leftNumber = left === '' ? -Infinity : parseFloat(left);
					var rightNumber = right === '' ? -Infinity : parseFloat(right);
					if (leftNumber < rightNumber) return -1;
					if (leftNumber > rightNumber) return 1;
					return 0;
				}

				return left.localeCompare(right, undefined, { sensitivity: 'base', numeric: true });
			};
		}

		function syncSortIndicators(containerId) {
			var container = document.getElementById(containerId);
			if (!container) return;

			var buttons = container.querySelectorAll('button.sort');
			buttons.forEach(function (button) {
				var icon = button.querySelector('.sort-indicator');
				if (!icon) return;

				icon.classList.remove('fa-sort', 'fa-arrow-up', 'fa-arrow-down');

				if (button.classList.contains('asc')) {
					icon.classList.add('fa-arrow-up');
					button.setAttribute('aria-sort', 'ascending');
				} else if (button.classList.contains('desc')) {
					icon.classList.add('fa-arrow-down');
					button.setAttribute('aria-sort', 'descending');
				} else {
					icon.classList.add('fa-sort');
					button.setAttribute('aria-sort', 'none');
				}
			});
		}

		function init() {
			if (!window.List) return;

			var list = new window.List('shop-vehicles-list', {
				valueNames: ['vehicle-type', 'vehicle-id', 'vehicle-name', 'vehicle-buy'],
				sortFunction: createSortFunction(['vehicle-id', 'vehicle-buy'])
			});
			list.on('sortComplete', function () {
				syncSortIndicators('shop-vehicles-list');
			});
			syncSortIndicators('shop-vehicles-list');
		}

		if (document.readyState === 'loading') {
			document.addEventListener('DOMContentLoaded', function () {
				loadListJs(init);
			});
		} else {
			loadListJs(init);
		}
	})();
</script>
