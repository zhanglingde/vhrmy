/**
 * Copyright 2018 人人开源 http://www.renren.io
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package com.ling.vhr.common.utils;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.AbstractList;
import java.util.List;

/**
 * 分页工具类
 */
@ApiModel("分页模型")
@Data
public class PageUtils<T> {
	/**
	 * 总记录数
	 */
	@ApiModelProperty(value="总记录数")
	private Long total;
	/**
	 * 每页记录数
	 */
	@ApiModelProperty(value="每页记录数")
	private Integer pageSize;
	/**
	 * 总页数
	 */
	@ApiModelProperty(value="总页数")
	private Integer totalPage;
	/**
	 * 当前页数
	 */
	@ApiModelProperty(value="当前页数")
	private Integer currPage;
	/**
	 * 列表数据
	 */
	@ApiModelProperty(value="列表数据")
	private List<T> list;

	public List<T> getList() {
		return list;
	}


	public PageUtils() {
	}


	public PageUtils(List<T> list, Long totalCount, Integer pageSize, Integer currPage) {
		this.list = list;
		this.total = totalCount;
		this.pageSize = pageSize;
		this.currPage = currPage;
		this.totalPage = (int) Math.ceil((double)totalCount/pageSize);
	}

	public PageUtils<T> setList(List<T> list) {
		this.list = list;
		return this;
	}

}
